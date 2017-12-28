RSpec.describe CXML::Protocol do
  it { is_expected.to respond_to :version }
  it { is_expected.to respond_to :request_elements }
  it { is_expected.to respond_to :response_elements }
  it { is_expected.to respond_to :status_codes }

  context "#version" do
    it "returns current protocol version" do
      expect(subject.version).to eq("1.2.011")
    end
  end
end
