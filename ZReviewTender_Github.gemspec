versionFilePath = ".version"
version = '1.1.1'
if File.exists?(versionFilePath)
    version = File.read(versionFilePath)
end

files = Dir['lib/**/*.*']
files.append('config/android.example.yml')
files.append('config/apple.example.yml')
files.append('.version')

Gem::Specification.new do |gem|
    gem.authors       = ['ZhgChgLi']
    gem.description   = 'ZReviewTender - App Reviews Automatic Bot'
    gem.summary       = 'ZReviewTender uses brand new App Store & Google Play API to fetch App reviews and integration your workflow.'
    gem.homepage      = 'https://github.com/ZhgChgLi/ZReviewTender'
    gem.files         = files
    gem.executables   = ['ZReviewTender']
    gem.name          = 'zreviewtender'
    gem.version       =  version
  
    gem.license       = "MIT"
  
    gem.add_dependency 'net-http', '~> 0.1.0'
    gem.add_dependency 'jwt', '~> 2.4.1'
    gem.add_dependency 'google-cloud-translate-v2', '~> 0.3.0'
    gem.add_dependency 'google-apis-androidpublisher_v3', '~> 0.25.0'
end