module CXML
  class Status
    attr_accessor :code, :text, :xml_lang

    # Initialize a new Status instance
    # @params data [Hash] optional hash with attributes
    def initialize(data=nil)
      data ||= {}

      if data.kind_of?(String)
        data = CXML.parse(data)
      end

      @code     = data["code"].to_i
      @text     = data["text"]
      @xml_lang = data["xml:lang"]
    end

    # Check if status is success
    # @return [Boolean]
    def success?
      [200, 201, 204, 280, 281].include?(code)
    end

    # Check if status is failure
    # @return [Boolean]
    def failure?
      !success?
    end

    def render(node)
      node.Status(code: code, text: text)
    end
  end
end