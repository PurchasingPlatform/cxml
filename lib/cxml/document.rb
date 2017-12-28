module CXML
  class Document
    attr_accessor :version, :payload_id, :timestamp
    attr_accessor :header, :request, :response

    def initialize(data = nil)
      data ||= {}

      return unless data['cXML']

      data = data['cXML'][0]
      @version = data['version']
      @payload_id = data['payloadID']
      @timestamp = Time.parse(data['timestamp']) if data['timestamp']
      @header = CXML::Header.new(data['Header']) if data['Header']
      @request = CXML::Request.new(data['Request']) if data['Request']
      @response = CXML::Response.new(data['Response']) if data['Response']
    end

    def setup
      @version = CXML::Protocol.version
      @timestamp = Time.now.utc
      @payload_id = "#{timestamp.to_i}.process.#{Process.pid}@domain.com"
    end

    # Check if document is request
    # @return [Boolean]
    def request?
      !request.nil?
    end

    # Check if document is a response
    # @return [Boolean]
    def response?
      !response.nil?
    end

    def render
      doc = CXML.builder
      doc << Ox::Element.new('cXML')
      doc.cXML['version'] = version
      doc.cXML['payloadID'] = payload_id
      doc.cXML['timestamp'] = timestamp.iso8601
      doc.cXML << header.render if header
      doc.cXML << response.render if response
      Ox.dump(doc, indent: 0, with_xml: true)
    end
  end
end
