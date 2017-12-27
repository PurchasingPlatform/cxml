module CXML
  class Status
    attr_accessor :code, :text, :xml_lang

    # Initialize a new Status instance
    # @param data [Hash] optional hash with attributes
    def initialize(data = nil)
      data ||= {}
      data = CXML.parse(data) if data.is_a?(String)

      @code = data['code'].to_i
      @text = data['text']
      @xml_lang = data['xml:lang']
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
      # node.Status(code: code, text: text)
      node << Ox::Element.new('Status')
      node.Status['code'] = code.to_s
      node.Status['text'] = text.to_s
    end
  end
end
