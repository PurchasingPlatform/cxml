module CXML
  class Document
    attr_accessor :version, :payload_id, :timestamp
    attr_accessor :header, :request, :response

    def initialize(data={})
      @version = data["version"]
      @payload_id = data["payloadID"]

      if data["timestamp"]
        @timestamp = Time.parse(data["timestamp"])
      end

      if data["Header"]
        @header = CXML::Header.new(data["Header"])
      end

      if data["Request"]
        @request = CXML::Request.new(data["Request"])
      end

      if data["Response"]
        @response = CXML::Response.new(data["Response"])
      end
    end

    def setup
      @version    = CXML::Protocol.version
      @timestamp  = Time.now.utc
      @payload_id = "#{timestamp.to_i}.process.#{Process.pid}@domain.com"
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
      node.cXML("version" => version, "payloadID" => payload_id, "timestamp" => timestamp.iso8601) do |doc|
        doc.Header { |n| header.render(n) } if header
        request.render(node) if request
        response.render(node) if response
      end
      node
    end
  end
end