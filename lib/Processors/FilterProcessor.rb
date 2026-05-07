$lib = File.expand_path('../lib', File.dirname(__FILE__))

require "Models/Review"
require "Models/Processor"
require "Models/FilterableProcessor"
require "Helper"

class FilterProcessor < Processor
    include FilterableProcessor

    register "filter"  # short alias for the new flat YAML format

    def validate_config!
        puts "[FilterProcessor] Init Success."
    end

    def process_reviews(reviews, platform)
        return reviews if reviews.empty?

        original = reviews.length
        result = apply_inclusion_filters(reviews)
        puts "[FilterProcessor] filter from #{original} to #{result.length}"
        result
    end
end
