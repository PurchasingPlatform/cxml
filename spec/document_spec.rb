require "spec_helper"

describe CXML::Document do
  let(:parser) { CXML::Parser.new }

  it { is_expected.to respond_to :version }
  it { is_expected.to respond_to :payload_id }
  it { is_expected.to respond_to :timestamp }

  describe "#parse" do
    it "sets document attributes" do
      data = parser.parse(fixture("envelope3.xml"))
      doc = nil

      expect { doc = CXML::Document.new(data) }.not_to raise_error

      expect(doc.version).to eq(CXML::Protocol::VERSION)
      expect(doc.payload_id).not_to be_nil
      expect(doc.timestamp).to be_a Time
      expect(doc.timestamp).to eq(Time.parse("2012-09-04T02:37:49-05:00"))

      expect(doc.header).to be_a CXML::Header
      expect(doc.request).to be_a CXML::Request
      expect(doc.response).to be_nil
    end
  end

  describe "#render" do
    it "returns and xml result" do
      doc = CXML::Document.new(parser.parse(fixture("envelope3.xml")))
      expect { doc.render }.not_to raise_error
    end
  end
end