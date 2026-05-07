$lib = File.expand_path('../', File.dirname(__FILE__))

# Shared keywordsInclude / ratingsInclude / territoriesInclude filtering
# previously copy-pasted across FilterProcessor / AsanaProcessor /
# GoogleSheetProcessor.
#
# The mixin reads its three lists directly from `config` so it works
# without any extra wiring in the host class.
module FilterableProcessor
    def filter_lists
        {
            ratings:     Array(config["ratingsInclude"]),
            territories: Array(config["territoriesInclude"]),
            keywords:    Array(config["keywordsInclude"]).reject { |k| k.to_s.empty? }
        }
    end

    def apply_inclusion_filters(reviews)
        lists = filter_lists
        result = reviews

        unless lists[:ratings].empty?
            wanted = lists[:ratings].map { |r| r.to_i }
            result = result.select { |r| wanted.include?(r.rating) }
        end

        unless lists[:territories].empty?
            wanted = lists[:territories].map { |t| t.to_s.upcase }
            result = result.select { |r| !r.territory.nil? && wanted.include?(r.territory.upcase) }
        end

        lists[:keywords].each do |kw|
            result = result.select { |r| !r.body.nil? && r.body.include?(kw) }
        end

        result
    end
end
