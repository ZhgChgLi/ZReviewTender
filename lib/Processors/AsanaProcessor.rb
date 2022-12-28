$lib = File.expand_path('../lib', File.dirname(__FILE__))

require "Models/Review"
require "Models/Processor"
require "Helper"
require "pathname"
require "GoogleAPI"

class AsanaProcessor < Processor

    attr_accessor :keywordsInclude, :ratingsInclude, :territoriesInclude, :logger, :timeZoneOffset, :token, :projectID, :sectionName, :taskTitleTemplate, :taskBodyTemplate, :asanaAPIURL

    def initialize(config, configFilePath, baseExecutePath)
        @config = config
        @configFilePath = configFilePath
        @baseExecutePath = baseExecutePath
        @logger = ZLogger.new(baseExecutePath)

        @asanaAPIURL = "https://app.asana.com/api/1.0"
        @token = Helper.unwrapRequiredParameter(config, "asanaToken")
        @projectID = Helper.unwrapRequiredParameter(config, "asanaProjectID")
        @taskTitleTemplate = Helper.unwrapRequiredParameter(config, "asanaTaskTitleTemplate")
        @taskBodyTemplate = Helper.unwrapRequiredParameter(config, "asanaTaskBodyTemplate")
        @timeZoneOffset = Helper.unwrapRequiredParameter(config, "asanaTimeZoneOffset")
        @sectionName = nil
        if !config["asanaSectionName"].nil? && config["asanaSectionName"] != ""
            @sectionName = config["asanaSectionName"].strip
        end

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

        puts "[AsanaProcessor] Init Success."
    end

    def processReviews(reviews, platform)        
        if reviews.length < 1
            return reviews
        end

        sectionID = findSectionIDFromSectionName(sectionName)

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

        filterReviews.each do |review|
            title = renderReview(taskTitleTemplate, review, timeZoneOffset)
            body = renderReview(taskBodyTemplate, review, timeZoneOffset)
            
            requestTaskData = {
                "name": title,
                "notes": body,
                "projects": [projectID.to_s]
            }

            if !review.createdDateTimestamp.nil?
                requestTaskData['due_at'] = Time.at(review.createdDateTimestamp).iso8601
            end

            taskData = asanaAPI("/tasks", "POST", requestTaskData)
            taskData = taskData["data"]
            
            if !sectionID.nil? && !taskData.nil?
                asanaAPI("/sections/#{sectionID}/addTask", "POST", {"task": taskData["gid"]})
            end

            puts "[AsanaProcessor] Insert Review #{title} as a task to asana project."
        end

        return reviews
    end

    private
    def findSectionIDFromSectionName(sectionName)
        if !sectionName.nil?
            sections = asanaAPI("/projects/#{projectID}/sections")["data"]
            section = sections.find{ |section| section["name"].strip == sectionName }
            if !section.nil?
                return section["gid"]
            end
        end

        return nil
    end

    private
    def asanaAPI(path, method = "GET", data = nil)
        uri = URI(asanaAPIURL+path)
        https = Net::HTTP.new(uri.host, uri.port)
        https.use_ssl = true
        
        request = Net::HTTP::Get.new(uri)
        if method.upcase == "POST"
            request = Net::HTTP::Post.new(uri)
            if !data.nil?
                request['Content-Type'] = 'application/json'
                request.body = JSON.dump({"data": data})
            end
        end
        
        request['Authorization'] = "Bearer #{token}";
        
        response = https.request(request).read_body
        result = JSON.parse(response)
    end
end