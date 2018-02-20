require "helpers/document"

describe CXML::PunchoutSetupResponse do

  describe "#to_xml" do
    let(:origin) { 'origin.foo' }

    let(:start_page_url) { 'https://url.to/cXML/punchOutSetupStartPage' }

    let(:valid_constructor_opts) do
      {
        origin: origin,

        status_code: 200,
        status_text: "success",

        start_page_url: start_page_url
      }
    end
    
    let(:punchout_setup_response) { described_class.new(valid_constructor_opts) }

    let(:expected_xml) { fixture("punchout_setup_response.xml") }

    let(:payload_id)   { 'sample_payload_id' }
    let(:timestamp)    { 'timestamp_mock' }

    it "should match xml", mock_payload_id: true, mock_timestamp: true do
      expect(punchout_setup_response.to_xml).to eq(expected_xml)
    end
  end

  describe "#parse" do
    let(:xml) { fixture("punchout_setup_response_global_industrial.xml") }

    it "should parse" do
      response = CXML::PunchoutSetupResponse.parse(xml)
      expect(response.status_code).to     eq(200)
      expect(response.status_text).to     eq("success")
      expect(response.start_page_url).to  eq("https://url.to/cXML/punchOutSetupStartPage")
    end
  end
end
