$lib = File.expand_path('../lib', File.dirname(__FILE__))

require "Models/Review"
require "Models/Processor"
require "Models/FilterableProcessor"
require "Helper"
require "ZLogger"
require "net/http"
require "json"
require "time"

class AsanaProcessor < Processor
    include FilterableProcessor

    register "asana"

    # tempData key this processor produces.
    TEMPDATA_ASANA_TASK_GID = "asanaTaskGID".freeze

    ASANA_API_BASE = "https://app.asana.com/api/1.0".freeze

    attr_accessor :timeZoneOffset, :token, :projectID, :sectionName, :taskTitleTemplate, :taskBodyTemplate

    def validate_config!
        @token             = Helper.unwrapRequiredParameter(config, "asanaToken")
        @projectID         = Helper.unwrapRequiredParameter(config, "asanaProjectID")
        @taskTitleTemplate = Helper.unwrapRequiredParameter(config, "asanaTaskTitleTemplate")
        @taskBodyTemplate  = Helper.unwrapRequiredParameter(config, "asanaTaskBodyTemplate")
        @timeZoneOffset    = Helper.unwrapRequiredParameter(config, "asanaTimeZoneOffset")
        @sectionName       = nil
        if !config["asanaSectionName"].nil? && config["asanaSectionName"] != ""
            @sectionName = config["asanaSectionName"].strip
        end

        puts "[AsanaProcessor] Init Success."
    end

    def asanaAPIURL
        ASANA_API_BASE
    end

    def process_reviews(reviews, platform)
        return reviews if reviews.empty?

        sectionID = findSectionIDFromSectionName(sectionName)

        filterReviews = apply_inclusion_filters(reviews)

        filterReviews.each do |review|
            title = render_review(taskTitleTemplate, review, timeZoneOffset)
            body  = render_review(taskBodyTemplate, review, timeZoneOffset)

            requestTaskData = {
                "name": title,
                "notes": body,
                "projects": [projectID.to_s]
            }

            if !review.createdDateTimestamp.nil?
                requestTaskData['due_at'] = Time.at(review.createdDateTimestamp).iso8601
            end

            taskData = asana_request("/tasks", "POST", requestTaskData)
            taskData = taskData["data"]

            review.tempData[TEMPDATA_ASANA_TASK_GID] = taskData["gid"]

            if !sectionID.nil? && !taskData.nil?
                asana_request("/sections/#{sectionID}/addTask", "POST", {"task": taskData["gid"]})
            end

            puts "[AsanaProcessor] Insert Review #{title} as a task to asana project."
        end

        reviews
    end

    private

    def findSectionIDFromSectionName(sectionName)
        return nil if sectionName.nil?
        sections = asana_request("/projects/#{projectID}/sections")["data"]
        section  = sections.find { |s| s["name"].strip == sectionName }
        section.nil? ? nil : section["gid"]
    end

    def asana_request(path, method = "GET", data = nil)
        uri = URI(ASANA_API_BASE + path)
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

        request['Authorization'] = "Bearer #{token}"

        response = https.request(request).read_body
        JSON.parse(response)
    end
end
