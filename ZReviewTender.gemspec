Gem::Specification.new do |gem|
    gem.authors       = ['ZhgChgLi']
    gem.description   = 'ZReviewTender - App Reviews Automatic Bot'
    gem.summary       = 'ZReviewTender uses brand new App Store & Google Play API to resend App reviews to your Slack channel automatically.'
    gem.homepage      = 'https://github.com/ZhgChgLi/ZReviewTender'
    gem.files         = Dir['lib/**/*.*']
    gem.executables   = ['ZReviewTender']
    gem.name          = 'ZReviewTender'
    gem.version       = '1.0.5'
  
    gem.license       = "MIT"
  
    gem.add_dependency 'net-http', '~> 0.1.0'
    gem.add_dependency 'jwt', '~> 2.4.1'
    gem.add_dependency 'google-cloud-translate-v2', '~> 0.3.0'
    gem.add_dependency 'google-apis-androidpublisher_v3', '~> 0.25.0'
end