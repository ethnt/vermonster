require "spork"

Spork.prefork do
  require_relative "../lib/vermonster"

  require "rspec"
  require "vcr"
  require "webmock/rspec"

  VCR.configure do |c|
    c.cassette_library_dir = "spec/fixtures/cassettes"
    c.hook_into :webmock
  end

  RSpec.configure do |c|
    c.extend VCR::RSpec::Macros
  end

  def oauth!
    @client = {
      :id => "f8d4f247547ad5315dd7127c7799a737",
      :secret => "e8ae0a776a78772412b66635f718776b"
    }

    @cheddar = Vermonster::Client.new(:id => @client[:id], :secret => @client[:secret])
    @cheddar.use_token!("6e8c9e570805e75d683a963b1290116a")
  end
end
