module CXML
  class Status
    attr_accessor :code, :text, :xml_lang

    # Initialize a new Status instance
    # @param data [Hash] optional hash with attributes
    def initialize(data = nil)
      data ||= {}
      data = CXML.parse(data)['Status'][0] if data.is_a?(String)

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

    def render
      node = Ox::Element.new('Status')
      node['code'] = code.to_s
      node['text'] = text.to_s
      node
    end
  end
end
