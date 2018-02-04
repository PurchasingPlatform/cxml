describe CXML::PunchoutSetupRequest do
  let(:origin) { 'origin.foo' }

  let(:from_credential) do
    CXML::Credential.new({
      domain: 'CustomDomain',
      identity: 'from'
    })
  end

  let(:to_credential) do
    CXML::Credential.new({
      domain: 'CustomDomain',
      identity: 'to'
    })
  end

  let(:shared_secret) { 'shared_foo' }

  let(:browser_form_post_url) { 'https://buyer.host/endpoint' }
  let(:supplier_setup_url)    { 'https://vendor.host/endpoint' }

  let(:user) do
    CXML::User.new({
      email:        'user@e.mail',
      unique_name:  'foouser'
    }) 
  end

  let(:valid_constructor_opts) do
    {
      origin: origin,

      operation:      :create,
      from:           from_credential,
      to:             to_credential,
      shared_secret:  shared_secret,

      browser_form_post_url: browser_form_post_url,
      supplier_setup_url:    supplier_setup_url,

      user: user
    }
  end

  let(:buyer_cookie) { 'fookie' }
  let(:payload_id)   { 'sample_payload_id' }
  let(:timestamp)    { 'timestamp_mock' }

  let(:expected_xml) { fixture("punchout_setup_request.xml") }

  let(:punchout_setup_request) { described_class.new(valid_constructor_opts) }

  describe "#render" do
    before do
      allow(SecureRandom).to receive(:hex).and_return(buyer_cookie)
      allow_any_instance_of(CXML::Document)
        .to receive(:payload_id)
        .and_return(payload_id)

      allow_any_instance_of(CXML::Document)
        .to receive(:timestamp)
        .and_return(double(:timestamp, iso8601: timestamp, to_i: timestamp))
    end

    it "should match xml" do
      expect(punchout_setup_request.render.to_xml).to eq(expected_xml)
    end
  end
end
