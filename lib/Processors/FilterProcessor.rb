$lib = File.expand_path('../lib', File.dirname(__FILE__))

require "Models/Review"
require "Models/Processor"
require "Helper"

class FilterProcessor < Processor

    attr_accessor :keywordsInclude, :ratingsInclude, :territoriesInclude

    def initialize(config, configFilePath, baseExecutePath)
        @config = config
        @configFilePath = configFilePath
        @baseExecutePath = baseExecutePath

        @keywordsInclude = []
        if !config["keywordsInclude"].nil?
            @keywordsInclude = config["keywordsInclude"]
        end

        @ratingsInclude = []
        if !config["ratingsInclude"].nil?
            @ratingsInclude = config["ratingsInclude"]
        end

        @territoriesInclude = []
        if !config["territoriesInclude"].nil?
            @territoriesInclude = config["territoriesInclude"]
        end

        puts "[FilterProcessor] Init Success."
    end

    def processReviews(reviews, platform)
        if reviews.length < 1
            return reviews
        end
        
        if ratingsInclude.length > 0
            orgReviewsCount = reviews.length
            reviews = reviews.select{ |review| ratingsInclude.map{ |rating| rating.to_i }.include? review.rating }
            puts "[FilterProcessor] filter out ratings from #{orgReviewsCount} to #{reviews.length}"
        end

        if territoriesInclude.length > 0
            orgReviewsCount = reviews.length
            reviews = reviews.select{ |review| territoriesInclude.map{ |territory| territory.upcase }.include? review.territory.upcase }
            puts "[FilterProcessor] filter out ratings from #{orgReviewsCount} to #{reviews.length}"
        end

        if keywordsInclude.length > 0
            orgReviewsCount = reviews.length
            keywordsInclude.select{ |keywordsInclude| keywordsInclude != "" }.each do |keywordInclude|
                reviews = reviews.select{ |review| review.body.include? keywordInclude }
            end
            puts "[FilterProcessor] filter out ratings from #{orgReviewsCount} to #{reviews.length}"
        end

        return reviews
    end

end