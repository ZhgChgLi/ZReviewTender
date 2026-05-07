$lib = File.expand_path('../lib', File.dirname(__FILE__))

require "Models/Review"
require "Models/Processor"
require "Helper"

# Reference template for writing your own Processor.
#
# In your YAML config:
#
#   processors:
#     - type: "ProcessorTemplate"      # registry key (class name or alias)
#       enable: true
#       require: "my_gem/cool_processor" # optional — load an external gem
#       parameter1: "value"
#       parameter2: "value"
#
# Override #validate_config! for fail-fast config checks at boot.
# Override #process_reviews to transform / filter / dispatch reviews. Always
# return the (possibly modified) reviews array so downstream processors get
# the result.
class ProcessorTemplate < Processor

    register "template"   # short alias for the new flat YAML format

    def validate_config!
        # @param1 = Helper.unwrapRequiredParameter(config, "parameter1")
    end

    def process_reviews(reviews, platform)
        return reviews if reviews.empty?

        # ... do something with reviews ...

        reviews
    end
end
