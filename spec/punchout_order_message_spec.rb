describe CXML::PunchoutOrderMessage do
  describe "#parse" do
    let(:xml) { fixture("punchout_order_message_global_industrial.xml") }

    let(:from_domain)     { "NetworkID_from" }
    let(:from_identity)   { "001472216_from" }
    let(:to_domain)       { "NetworkID_to" }
    let(:to_identity)     { "5168_to" }
    let(:shared_secret)   { "theSharedSecret" }

    let(:buyer_cookie)    { "1407b4b6011cdee21b689d4cbe55c878" }
    let(:total)           { 1919.05 }
    let(:total_currency)  { "USD" }

    let(:supplier_part_id)            { "T9TB402299" }
    let(:supplier_part_auxiliary_id)  { "1407b4b6011cdee21b689d4cbe55c878" }
    let(:unit_price)                  { 90.86 }
    let(:unit_price_currency)         { "USD" }
    let(:quantity)                    { 1 }
    let(:unit_of_measure)             { "EA" }
    let(:item_description)            { "#8 x 1-1/4 Bugle Square Drive Course Thread Type 17 Point Deck Screw 18-8 Stainless Steel,1500 pcs" }
    let(:classifictaion_unspsc)       { "31161500" }


    it "should parse Global Industrial xml" do
      message = described_class.parse(xml)
      header  = message.header

      expect(header.from.domain).to           eq(from_domain)
      expect(header.from.identity).to         eq(from_identity)
      expect(header.to.domain).to             eq(to_domain)
      expect(header.to.identity).to           eq(to_identity)
      expect(header.sender.domain).to         eq(to_domain)
      expect(header.sender.identity).to       eq(to_identity)
      expect(header.sender.shared_secret).to  eq(shared_secret)

      expect(message.buyer_cookie).to         eq(buyer_cookie)
      expect(message.total.amount).to         eq(total)
      expect(message.total.currency).to       eq(total_currency)

      expect(message.items.length).to eq(3)
      
      first = message.items.first
      expect(first.supplier_part_id).to             eq(supplier_part_id)
      expect(first.supplier_part_auxiliary_id).to   eq(supplier_part_auxiliary_id)
      expect(first.unit_price.amount).to            eq(unit_price)
      expect(first.unit_price.currency).to          eq(unit_price_currency)
      expect(first.quantity).to                     eq(quantity)
      expect(first.unit_of_measure).to              eq(unit_of_measure)
      expect(first.description).to                  eq(item_description)
      expect(first.classifictaion_unspsc).to        eq(classifictaion_unspsc)                      
    end

    context "no products"
    context "no classification"
    context "description without xml:lang"
    context "multiple credentials in From/To/Sender"
    context "multiple money nodes"
    context "multiple classification nodes"
    context "multiple description nodes"
  end
end
