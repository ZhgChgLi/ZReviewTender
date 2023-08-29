$lib = File.expand_path('../', File.dirname(__FILE__))

class Review
    attr_accessor :platform, :id, :userName, :rating, :title, :body, :createdDateTimestamp, :url, :appVersion, :territory, :tempData
    def initialize(platform, id, userName, rating, title, body, createdDateTimestamp, url, appVersion, territory, tempData)
        @platform = platform # 來源平台 android or apple
        @id = id # review id
        @userName = userName # reviewer
        @rating = rating # 給予的 rating, 1~5
        @title = title # review 標題 (android 無此資料)
        @body = body # review 內容
        @createdDateTimestamp = createdDateTimestamp # review 建立時間
        @url = url # 前往 review 的連結 (apple 不提供後台指定到某個 review 的連結)
        @appVersion = appVersion # app 版本號
        @territory = territory # apple: 地區(TWN/JPN...), android: 語系(zh-tw/en...)
        @tempData = tempData # 程式內部傳遞使用
    end
end