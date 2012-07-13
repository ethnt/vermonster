require_relative "../lib/vermonster"

require "rspec"
require "webmock/rspec"
require "vcr"

VCR.configure do |c|
  c.cassette_library_dir = "spec/fixtures/cassettes"
  c.hook_into :webmock
end

RSpec.configure do |c|
  c.extend VCR::RSpec::Macros
end