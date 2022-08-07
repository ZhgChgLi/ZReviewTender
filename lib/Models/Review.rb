$lib = File.expand_path('../', File.dirname(__FILE__))

class Review
    attr_accessor :platform, :id, :userName, :rating, :title, :body, :createdDateTimestamp, :url, :appVersion, :territory
    def initialize(platform, id, userName, rating, title, body, createdDateTimestamp, url, appVersion, territory)
        @platform = platform
        @id = id
        @userName = userName
        @rating = rating
        @title = title
        @body = body
        @createdDateTimestamp = createdDateTimestamp
        @url = url
        @appVersion = appVersion
        @territory = territory
    end
end