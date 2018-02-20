RSpec.configure do |c|
  c.before(:each, mock_payload_id: true) do
    allow_any_instance_of(CXML::Document)
      .to receive(:payload_id)
      .and_return(payload_id)
  end

  c.before(:each, mock_timestamp: true) do
    allow_any_instance_of(CXML::Document)
      .to receive(:timestamp)
      .and_return(double(:timestamp, iso8601: timestamp, to_i: timestamp))
  end
end
