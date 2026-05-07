$LOAD_PATH.unshift(File.expand_path('../../lib', __FILE__))

require 'tmpdir'
require 'webmock/rspec'
WebMock.disable_net_connect!(allow_localhost: true)

require 'Helper'
require 'ZLogger'
require 'Models/Review'
require 'Models/ProcessorRegistry'
require 'Models/Processor'
require 'Models/FilterableProcessor'
require 'Models/WelcomeMessageCapable'
require 'Models/ProcessorLoader'

Dir[File.expand_path('support/**/*.rb', __dir__)].sort.each { |f| require f }

RSpec.configure do |c|
    c.expect_with(:rspec) { |e| e.syntax = :expect }
    c.example_status_persistence_file_path = ".rspec_status"

    # Snapshot the registry at first use, then restore it before every spec
    # so processor classes loaded by earlier examples don't leak across tests.
    c.before(:suite) do
        SPEC_REGISTRY_BASELINE = ProcessorRegistry.entries.dup.freeze
    end

    c.before(:each) do
        ProcessorRegistry.reset!
        SPEC_REGISTRY_BASELINE.each { |k, v| ProcessorRegistry.register(k, v) } if defined?(SPEC_REGISTRY_BASELINE)
    end
end
