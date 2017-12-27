module CXML
  class Document
    attr_accessor :version, :payload_id, :timestamp
    attr_accessor :header, :request, :response

    def initialize(data = {})
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
      # node = CXML.builder
      # node.cXML('version' => version, 'payloadID' => payload_id, 'timestamp' => timestamp.iso8601) do |doc|
      #   doc.Header { |n| header.render(n) } if header
      #   request.render(node) if request
      #   response.render(node) if response
      # end
      # node
      binding.pry
      doc = CXML.builder
      doc << Ox::Element.new('cXML')
      doc.cXML['version'] = version
      doc.cXML['payloadID'] = payload_id
      doc.cXML['timestamp'] = timestamp.iso8601

      if header
        doc.cXML << Ox::Element.new('Header')
        doc.cXML.Header = header.render(doc.cXML.Header)
      end

      doc.cXML << request.render(doc) if request
      doc.cXML << response.render(doc) if response
      doc
    end
  end
end
