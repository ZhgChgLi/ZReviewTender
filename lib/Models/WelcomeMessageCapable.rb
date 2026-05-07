$lib = File.expand_path('../', File.dirname(__FILE__))

# Marker module. A processor that can deliver an "init success" welcome
# message should `include WelcomeMessageCapable` and implement:
#
#     def send_welcome_message(platform)
#       ...
#     end
#
# ReviewFetcher uses this marker (instead of hard-coding SlackProcessor)
# so any third-party processor can opt in.
module WelcomeMessageCapable
end
