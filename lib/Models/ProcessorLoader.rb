$lib = File.expand_path('../', File.dirname(__FILE__))

require "Models/ProcessorRegistry"

# Loads a list of processor config blocks (as parsed from YAML) into
# instantiated Processor objects.
#
# Two YAML shapes are supported:
#
#   New (recommended):
#     processors:
#       - type: "SlackProcessor"            # registry key
#         enable: true
#         require: "my_gem/cool_processor"  # optional: load external file/gem
#         slackBotToken: "..."
#
#   Legacy (still supported, emits a deprecation warning):
#     processors:
#       - SlackProcessor:
#           class: "SlackProcessor"
#           enable: true
#           ...
#
# This class replaces the earlier `eval`-based instantiation in
# bin/ZReviewTender. It validates input, resolves the processor class via
# ProcessorRegistry, and surfaces clear errors when something is wrong.
class ProcessorLoader
    LEGACY_KEYS = %w[type enable require].freeze

    def self.load(blocks, config_file_path, base_execute_path)
        processors = []
        Array(blocks).each_with_index do |block, idx|
            entry = normalize_block(block, idx)
            next unless entry[:enable]

            require_external(entry[:require]) if entry[:require]
            require_builtin_if_needed(entry[:type])

            klass = ProcessorRegistry.lookup!(entry[:type])
            processors << instantiate(klass, entry[:config], config_file_path, base_execute_path)
        end
        processors
    end

    def self.normalize_block(block, idx)
        unless block.is_a?(Hash)
            raise "processors[#{idx}] must be a mapping, got #{block.class}"
        end

        if block.key?("type")
            return {
                type:    block.fetch("type"),
                enable:  block.fetch("enable", true) == true,
                require: block["require"],
                config:  block.reject { |k, _| LEGACY_KEYS.include?(k) }
            }
        end

        if block.size == 1
            outer_key, inner = block.first
            unless inner.is_a?(Hash)
                raise "processors[#{idx}] '#{outer_key}' value must be a mapping"
            end
            klass_name = inner["class"] || outer_key
            warn "[ZReviewTender] DEPRECATION: processors[#{idx}] uses the legacy {#{outer_key}: { class: '#{klass_name}', ... }} format. Please migrate to the flat 'type:' format. See README."
            return {
                type:    klass_name,
                enable:  inner["enable"] == true,
                require: inner["require"],
                config:  inner
            }
        end

        raise "processors[#{idx}] is malformed: expected 'type:' or single-key legacy mapping"
    end

    def self.require_external(path)
        require path
    rescue LoadError => e
        raise "Failed to require external processor '#{path}': #{e.message}"
    end

    def self.require_builtin_if_needed(type)
        return if ProcessorRegistry.lookup(type)
        begin
            require "Processors/#{type}"
        rescue LoadError
            # let the subsequent lookup! raise a clear message
        end
    end

    def self.instantiate(klass, config, config_file_path, base_execute_path)
        klass.new(
            config:            config,
            config_file_path:  config_file_path,
            base_execute_path: base_execute_path
        )
    rescue ArgumentError
        # Fall back to the legacy positional signature for user processors
        # that still have:
        #   def initialize(config, configFilePath, baseExecutePath)
        klass.new(config, config_file_path, base_execute_path)
    end
end
