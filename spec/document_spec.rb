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

  describe 'Response' do
    context 'when building a punchout setup response' do
      let(:doc) do
        doc = described_class.new
        doc.setup
        doc.response = CXML::Response.new
        doc.response.punchout_setup_url = 'http://example.com'
        doc
      end

      it 'sets the punchout setup URL correctly' do
        expect(doc.response.punchout_setup_url).to eq 'http://example.com'
      end

      it 'renders an XML document without failures' do
        expect { doc.render }.not_to raise_error
      end
    end
  end

  describe 'OrderMessage' do
    context 'when building a punchout order message' do
      let(:doc) do
        doc = described_class.new
        doc.setup
        doc.order_message = CXML::OrderMessage.new
        doc.order_message.buyer_cookie = 'a'
        doc.order_message.allowed_operation = 'e'
        doc.order_message.total = CXML::Money.new
        doc.order_message.total.currency = 'USD'
        doc.order_message.total.amount = 700.01
        item = CXML::Item.new
        item.qty = 3
        item.supplier_id = 100_500
        item.supplier_auxiliary_id = 1_010_101_010
        item.unit_price = 100
        item.unit_price = CXML::Money.new
        item.unit_price.currency = 'USD'
        item.unit_price.amount = 100
        item.description = 'test'
        item.unit_of_measure = 'EA'
        item.lang = 'en'
        item.name = 'test'
        doc.order_message.items = []
        3.times { doc.order_message.items << item }
        doc
      end

      it 'renders an XML document without failures' do
        expect { doc.render }.not_to raise_error
      end
    end
  end
end
