$lib = File.expand_path('../lib', File.dirname(__FILE__))

require "Models/Review"
require "Models/Processor"
require "Helper"
require "pathname"
require "GoogleAPI"

class GoogleSheetProcessor < Processor

    attr_accessor :keywordsInclude, :ratingsInclude, :territoriesInclude, :logger, :googleAPI, :sheetID, :sheetName, :formatValues, :timeZoneOffset

    def initialize(config, configFilePath, baseExecutePath)
        @config = config
        @configFilePath = configFilePath
        @baseExecutePath = baseExecutePath
        @logger = ZLogger.new(baseExecutePath)

        keyFilePath = Helper.unwrapRequiredParameter(config, "googleSheetAPIKeyFilePath")

        if Pathname.new(keyFilePath).absolute?
            configDir = File.dirname(configFilePath)
            keyFilePath = "#{configDir}#{keyFilePath}"
        end

        @googleAPI = GoogleAPI.new(keyFilePath, baseExecutePath, ["https://www.googleapis.com/auth/drive", "https://www.googleapis.com/auth/drive.file", "https://www.googleapis.com/auth/spreadsheets"])

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

        @timeZoneOffset = Helper.unwrapRequiredParameter(config, "googleSheetTimeZoneOffset")
        @sheetID = Helper.unwrapRequiredParameter(config, "googleSheetID")
        @sheetName = Helper.unwrapRequiredParameter(config, "googleSheetName")
        @formatValues = []
        if !config["values"].nil?
            @formatValues = config["values"]
        end

        puts "[GoogleSheetProcessor] Init Success."
    end

    def processReviews(reviews, platform)
        
        if reviews.length < 1
            return reviews
        end

        filterReviews = reviews
        
        if ratingsInclude.length > 0
            filterReviews = filterReviews.select{ |review| ratingsInclude.map{ |rating| rating.to_i }.include? review.rating }
        end

        if territoriesInclude.length > 0
            filterReviews = filterReviews.select{ |review| territoriesInclude.map{ |territory| territory.upcase }.include? review.territory.upcase }
        end

        if keywordsInclude.length > 0
            keywordsInclude.select{ |keywordsInclude| keywordsInclude != "" }.each do |keywordInclude|
                filterReviews = filterReviews.select{ |review| review.body.include? keywordInclude }
            end
        end

        values = []
        filterReviews.each do |review|
            cols = []
            formatValues.each do |formatValue|
                formatValue = formatValue.gsub("%TITLE%", review.title || "")
                formatValue = formatValue.gsub("%BODY%", review.body || "")
                formatValue = formatValue.gsub("%RATING%", review.rating.nil? ? "" :review.rating.to_s)
                formatValue = formatValue.gsub("%PLATFORM%", review.platform || "")
                formatValue = formatValue.gsub("%ID%", review.id || "")
                formatValue = formatValue.gsub("%USERNAME%", review.userName || "")
                formatValue = formatValue.gsub("%URL%", review.url || "")
                formatValue = formatValue.gsub("%TERRITORY%", review.territory || "")
                formatValue = formatValue.gsub("%APPVERSION%", review.appVersion || "")
                formatValue = formatValue.gsub("%CREATEDDATE%", review.createdDateTimestamp.nil? ? "" : Time.at(review.createdDateTimestamp).getlocal(timeZoneOffset).to_s)

                cols.append(formatValue)
            end
            values.append(cols)
        end

        page = 1
        limit = 500
        values.each_slice(limit) do |value|
            puts "[GoogleSheetProcessor] Insert rows(#{page}/#{(values.length/limit).ceil + 1}) to #{sheetID}-#{sheetName}"
            page += 1
            googleAPI.request("https://sheets.googleapis.com/v4/spreadsheets/#{sheetID}/values/#{sheetName}!A1:append?valueInputOption=RAW", "POST", {:values => value})
        end

        return reviews
    end
end