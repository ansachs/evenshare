require 'vcr'

VCR.configure do |c|
  c.cassette_library_dir = 'spec/support/fixtures/vcr_cassettes'
  c.hook_into :webmock
  c.configure_rspec_metadata!
  c.default_cassette_options = { :record => :new_episodes, :re_record_interval => 1.days }
end