describe CXML::Status do
  describe "instance" do
    it { is_expected.to respond_to :code }
    it { is_expected.to respond_to :text }
    it { is_expected.to respond_to :xml_lang }
    it { is_expected.to respond_to :success? }
    it { is_expected.to respond_to :failure? }
  end

  describe "#initialize" do
    it "assigns attributes from string" do
      str = '<Status xml:lang="en-US" code="200" text="OK"></Status>'
      status = CXML::Status.new(str)

      expect(status.code).to eq(200)
      expect(status.xml_lang).to eq("en-US")
      expect(status.text).to eq("OK")
    end

    it "assigns attributes from hash" do
      hash = {"xml:lang" => "en-US", "code" => "200", "text" => "OK"}
      status = CXML::Status.new(hash)

      expect(status.code).to eq(200)
      expect(status.xml_lang).to eq("en-US")
      expect(status.text).to eq("OK")
    end
  end

  describe "#success?" do
    it "returns true on 2xx codes" do
      expect(CXML::Status.new("code" => "200").success?).to be true
      expect(CXML::Status.new("code" => "201").success?).to be true
      expect(CXML::Status.new("code" => "281").success?).to be true
    end

    it "returns false on non 2xx codes" do
      expect(CXML::Status.new("code" => "400").success?).to be false
      expect(CXML::Status.new("code" => "475").success?).to be false
      expect(CXML::Status.new("code" => "500").success?).to be false
    end
  end

  describe "#failure?" do
    it "returns false on 2xx codes" do
      expect(CXML::Status.new("code" => "200").failure?).to be false
    end
  end
end