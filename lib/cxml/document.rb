module CXML
  class Document
    attr_reader   :origin
    attr_accessor :version, :payload_id, :timestamp
    attr_accessor :header, :request, :response, :order_message

    DEFAULT_ORIGIN = "unspecified.origin"

    def initialize(data=nil)
      data ||= {}
      @origin = data[:origin] || DEFAULT_ORIGIN

      @version = data["version"]
      @payload_id = data["payloadID"]

      @timestamp  = Time.parse(data["timestamp"])         if data["timestamp"]
      @header     = CXML::Header.new(data["Header"])      if data["Header"]
      @request    = CXML::Request.new(data["Request"])    if data["Request"]
      @response   = CXML::Response.new(data["Response"])  if data["Response"]
    end

    def setup
      @version    = CXML::Protocol.version
      @timestamp  = Time.now.utc
      @payload_id = "#{timestamp.to_i}.process.#{Process.pid}@#{ origin }"
    end

    # Check if document is request
    # @return [Boolean]
    def request?
      !!request
    end

    # Check if document is a response
    # @return [Boolean]
    def response?
      !!response
    end

    def render
      node = CXML.builder
      node.doc.create_internal_subset(
        "cXML", nil, "http://xml.cxml.org/schemas/cXML/#{ Protocol.version }/cXML.dtd"
      )
      node.cXML(
        "xml:lang"  => "en-US",
        "version"   => version, 
        "payloadID" => payload_id, 
        "timestamp" => timestamp.iso8601
      ) do |doc|
        doc.Header { |n| header.render(n) } if header
        request.render(node) if request
        response.render(node) if response
        order_message.render(node) if order_message
      end
      node
    end
  end
end
