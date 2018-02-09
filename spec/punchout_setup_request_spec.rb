require "helpers/document"

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

  let(:ship_to) do
    CXML::Address.new({
      id:           'address_id',
      to:           'John Smith',
      street:       'Foo str',
      city:         'Chicago',
      state:        'IL',
      postal_code:  '12345',
      country: {
        iso_code: 'US',
        name:     'United States'
      }
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

      user: user,

      ship_to: ship_to
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
    end

    it "should match xml", mock_payload_id: true, mock_timestamp: true do
      expect(punchout_setup_request.to_xml).to eq(expected_xml)
    end
  end
end
