$lib = File.expand_path('../lib', File.dirname(__FILE__))

require "Models/Review"
require "Models/Processor"
require "Models/FilterableProcessor"
require "Helper"
require "pathname"
require "GoogleAPI"

class GoogleSheetProcessor < Processor
    include FilterableProcessor

    register "google_sheet"

    attr_accessor :googleAPI, :spreadsheetID, :sheetInsertType, :sheetId, :sheetName, :sheetInsertAt, :formatValues, :timeZoneOffset

    def validate_config!
        keyFilePath = Helper.unwrapRequiredParameter(config, "googleSheetAPIKeyFilePath")
        if Pathname.new(keyFilePath).absolute?
            configDir = File.dirname(configFilePath)
            keyFilePath = "#{configDir}#{keyFilePath}"
        end

        @googleAPI = GoogleAPI.new(keyFilePath, baseExecutePath, [
            "https://www.googleapis.com/auth/drive",
            "https://www.googleapis.com/auth/drive.file",
            "https://www.googleapis.com/auth/spreadsheets"
        ])

        @timeZoneOffset = Helper.unwrapRequiredParameter(config, "googleSheetTimeZoneOffset")
        @spreadsheetID  = Helper.unwrapRequiredParameter(config, "googleSpreadsheetID")

        sheetInsertStyle = Helper.unwrapRequiredParameter(config, "googleSheetInsertStyle")
        unless sheetInsertStyle.is_a?(Array)
            raise "googleSheetInsertStyle must specify as Array in GoogleSheetProcessor."
        end

        flat = {}
        sheetInsertStyle.each do |entry|
            entry.keys.each { |k| flat[k] = entry[k] }
        end

        @sheetInsertType = Helper.unwrapRequiredParameter(flat, "type")
        if sheetInsertType != "insert" && sheetInsertType != "append"
            raise "googleSheetInsertStyle.type only accept insert or append in GoogleSheetProcessor."
        elsif sheetInsertType == "insert"
            @sheetInsertAt = Helper.unwrapRequiredParameter(flat, "at").to_i
            @sheetId       = Helper.unwrapRequiredParameter(flat, "sheetID")
        elsif sheetInsertType == "append"
            @sheetName = Helper.unwrapRequiredParameter(flat, "sheetName")
        end

        @formatValues = Array(config["values"])

        puts "[GoogleSheetProcessor] Init Success."
    end

    def process_reviews(reviews, platform)
        return reviews if reviews.empty?

        filterReviews = apply_inclusion_filters(reviews)

        sortedFilterReviews = filterReviews
        if sheetInsertType == "insert"
            sortedFilterReviews = sortedFilterReviews.sort { |a, b| b.createdDateTimestamp <=> a.createdDateTimestamp }
        end

        values = sortedFilterReviews.map do |review|
            formatValues.map { |fv| render_review(fv, review, timeZoneOffset) }
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
                                    "rowIndex": sheetInsertAt
                                }
                            }
                        }
                    ]
                })
            elsif sheetInsertType == "append"
                googleAPI.request("https://sheets.googleapis.com/v4/spreadsheets/#{spreadsheetID}/values/#{sheetName}!A1:append?valueInputOption=RAW", "POST", {:values => value})
            end
        end

        reviews
    end

    private

    def rowsToString(rows)
        rows.map do |row|
            "\"#{row.map { |v| v.gsub('"', '\"') }.join('","')}\""
        end.join("\n")
    end
end
