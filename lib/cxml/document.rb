module CXML
  class Document
    attr_accessor :version, :payload_id, :timestamp
    attr_accessor :header, :request, :response

    def initialize(data = nil)
      data ||= {}

      return unless data['cXML']

      @version = data.deep_locate('version').first['version']
      @payload_id = data.deep_locate('payloadID').first['payloadID']

      if t = data.deep_locate('timestamp').first
        @timestamp = Time.parse(t['timestamp'])
      end

      if h = data.deep_locate('Header').first
        @header = CXML::Header.new(h['Header'])
      end

      if r = data.deep_locate('Request').first
        @request = CXML::Request.new(r)
      end

      if r = data.deep_locate('Response').first
        @response = CXML::Response.new(r)
      end
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
