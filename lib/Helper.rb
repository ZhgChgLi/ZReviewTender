$lib = File.expand_path('../', File.dirname(__FILE__))

class Helper
    def self.unwrapRequiredParameter(obj, key)
        if obj[key].nil?
            raise "Required Parameter Not Found: #{key}"
        else
            if obj[key] == ''
                raise "Required Parameter Is Empty: #{key}"
            else
                return obj[key]
            end
        end
    end

    def self.createDirIfNotExist(dirPath)
        dirs = dirPath.split("/")
        currentDir = ""
        begin
            dir = dirs.shift
            currentDir = "#{currentDir}/#{dir}"
            Dir.mkdir(currentDir) unless File.exists?(currentDir)
        end while dirs.length > 0
    end
end
