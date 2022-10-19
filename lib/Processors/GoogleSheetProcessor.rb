$lib = File.expand_path('../lib', File.dirname(__FILE__))

require "Models/Review"
require "Models/Processor"
require "Helper"
require "pathname"
require "GoogleAPI"

class GoogleSheetProcessor < Processor

    attr_accessor :keywordsInclude, :ratingsInclude, :territoriesInclude, :logger, :googleAPI, :spreadsheetID, :sheetInsertType, :sheetId, :sheetName, :sheetInsertAt, :formatValues, :timeZoneOffset

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
        @spreadsheetID = Helper.unwrapRequiredParameter(config, "googleSpreadsheetID")
        
        sheetInsertStyle = Helper.unwrapRequiredParameter(config, "googleSheetInsertStyle")
        if !sheetInsertStyle.is_a? Array
            raise "googleSheetInsertStyle must specify as Array in GoogleSheetProcessor."
        end

        sheetInsertStyles = {}
        sheetInsertStyle.each do |value|
            value.keys.each do |key|
                sheetInsertStyles[key] = value[key]
            end
        end

        @sheetInsertType = Helper.unwrapRequiredParameter(sheetInsertStyles, "type")

        if sheetInsertType != "insert" && sheetInsertType != "append"
            raise "googleSheetInsertStyle.type only accept insert or append in GoogleSheetProcessor."
        elsif sheetInsertType == "insert"
            @sheetInsertAt = Helper.unwrapRequiredParameter(sheetInsertStyles, "at").to_i
            @sheetId = Helper.unwrapRequiredParameter(sheetInsertStyles, "sheetID")
        elsif sheetInsertType == "append"
            @sheetName = Helper.unwrapRequiredParameter(sheetInsertStyles, "sheetName")
        end
        
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
        sortedFilterReviews = filterReviews
        if sheetInsertType == "insert"
            sortedFilterReviews = sortedFilterReviews.sort! { |a, b|  b.createdDateTimestamp <=> a.createdDateTimestamp }
        end

        sortedFilterReviews.each do |review|
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
        limit = 100
        values.each_slice(limit) do |value|
            puts "[GoogleSheetProcessor] Insert rows page:(#{page}/#{(values.length/limit).ceil + 1}) #{sheetInsertType} to #{spreadsheetID}"
            page += 1
            if sheetInsertType == "insert"
                googleAPI.request("https://sheets.googleapis.com/v4/spreadsheets/#{spreadsheetID}:batchUpdate", "POST", {
                    "requests": [
                        {
                            "insertRange": {
                                "range": {
                                    "sheetId": sheetId,
                                    "startRowIndex": sheetInsertAt,
                                    "endRowIndex": sheetInsertAt + value.length
                                },
                                "shiftDimension": "ROWS"
                            }
                        },
                        {
                            "pasteData": {
                                "data": rowsToString(value),
                                "type": "PASTE_NORMAL",
                                "delimiter": ",",
                                "coordinate": {
                                    "sheetId": sheetId,
                                    "rowIndex": sheetInsertAt,
                                }
                            }
                        }
                    ]
                })
            elsif sheetInsertType == "append"
                googleAPI.request("https://sheets.googleapis.com/v4/spreadsheets/#{spreadsheetID}/values/#{sheetName}!A1:append?valueInputOption=RAW", "POST", {:values => value})
            end
        end

        return reviews
    end

    private
    def rowsToString(rows)
        string = ""
        rows.each do |row|
            if string != "" 
                string += "\n"
            end
            string += "\"#{row.map{ |v| v.gsub('"','\"') }.join('","')}\""
        end
        return string
    end
end