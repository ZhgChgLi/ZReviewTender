$lib = File.expand_path('../', File.dirname(__FILE__))

require "Models/ProcessorRegistry"
require "ZLogger"
require "Helper"

# Abstract base class for all ZReviewTender processors.
#
# Public contract for subclasses:
#   * implement #process_reviews(reviews, platform) and return the (possibly
#     transformed) array of Review objects;
#   * optionally override .processor_name (defaults to the class name) or
#     call .register("name") to add additional registry aliases;
#   * optionally override #validate_config! to fail-fast at init time.
#
# Backward compatibility:
#   * subclasses written for the legacy API that override #processReviews
#     (camelCase) keep working — the default #process_reviews detects the
#     override, emits a one-line deprecation warning, and delegates to it.
#   * the legacy positional initializer `def initialize(config, configFilePath,
#     baseExecutePath)` is also supported (ProcessorLoader retries with the
#     positional form when keyword args fail).
#
# Inter-processor protocol — `Review#tempData` keys produced/consumed by
# the built-in processors:
#   "slackTS"         set by SlackProcessor          (Slack message ts)
#   "slackChannelID"  set by SlackProcessor          (target channel id)
#   "asanaTaskGID"    set by AsanaProcessor          (created Asana task gid)
# A processor that depends on another's tempData MUST be ordered after it
# in the YAML processors list. Each producing processor exposes named
# constants (e.g. SlackProcessor::TEMPDATA_SLACK_TS) so consumers don't have
# to hard-code the key names.
class Processor
    attr_reader :config, :configFilePath, :baseExecutePath, :logger
    alias_method :config_file_path, :configFilePath
    alias_method :base_execute_path, :baseExecutePath

    # Auto-register every concrete subclass under its class name.
    def self.inherited(subclass)
        super
        ProcessorRegistry.register(subclass.processor_name, subclass)
    end

    # Default registry key. Subclasses may override.
    def self.processor_name
        name
    end

    # Add an extra alias (or register a class manually).
    def self.register(name, klass = self)
        ProcessorRegistry.register(name, klass)
    end

    def initialize(config:, config_file_path:, base_execute_path:)
        @config           = config
        @configFilePath   = config_file_path
        @baseExecutePath  = base_execute_path
        @logger           = ZLogger.new(base_execute_path)
        validate_config!
    end

    # Hook for fail-fast config validation. Default no-op.
    def validate_config!
    end

    # Subclasses must override one of #process_reviews or #processReviews.
    # The default implementations dispatch to each other so legacy
    # processors that only override the camelCase form keep working.
    def process_reviews(reviews, platform)
        if self.class.instance_method(:processReviews).owner != Processor
            unless @_camel_deprecation_warned
                warn "[ZReviewTender] DEPRECATION: #{self.class}#processReviews is deprecated; please rename it to #process_reviews."
                @_camel_deprecation_warned = true
            end
            return processReviews(reviews, platform)
        end
        raise NotImplementedError, "#{self.class} must implement #process_reviews(reviews, platform)"
    end

    def processReviews(reviews, platform)
        process_reviews(reviews, platform)
    end

    def render_review(template_text, review, time_zone_offset)
        template_text
            .gsub("%TITLE%",       review.title       || "")
            .gsub("%BODY%",        review.body        || "")
            .gsub("%RATING%",      review.rating.nil? ? "" : review.rating.to_s)
            .gsub("%PLATFORM%",    review.platform    || "")
            .gsub("%ID%",          review.id          || "")
            .gsub("%USERNAME%",    review.userName    || "")
            .gsub("%URL%",         review.url         || "")
            .gsub("%TERRITORY%",   review.territory   || "")
            .gsub("%APPVERSION%",  review.appVersion  || "")
            .gsub("%CREATEDDATE%", review.createdDateTimestamp.nil? ? "" : Time.at(review.createdDateTimestamp).getlocal(time_zone_offset).to_s)
    end
    alias_method :renderReview, :render_review
end
