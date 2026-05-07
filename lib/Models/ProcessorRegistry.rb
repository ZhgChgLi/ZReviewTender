$lib = File.expand_path('../', File.dirname(__FILE__))

# Central registry mapping a processor name (string) to its class.
#
# Names are case-sensitive strings. A class may register itself under
# multiple names (e.g. its class name plus a shorter alias). The default
# registration happens automatically via Processor.inherited.
class ProcessorRegistry
    @entries = {}

    class << self
        attr_reader :entries

        def register(name, klass)
            key = name.to_s
            if @entries.key?(key) && @entries[key] != klass
                warn "[ZReviewTender] Processor '#{name}' is being re-registered (was #{@entries[key]}, now #{klass})."
            end
            @entries[key] = klass
        end

        def lookup(name)
            @entries[name.to_s]
        end

        def lookup!(name)
            klass = lookup(name)
            return klass unless klass.nil?
            raise KeyError, "No processor registered as '#{name}'. Registered: #{@entries.keys.sort.join(', ')}"
        end

        def reset!
            @entries = {}
        end
    end
end
