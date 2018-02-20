module CXML

  class PunchoutSetupResponse
    ATTRS = %i[ origin  status_code  status_text  start_page_url ]

    attr_reader *ATTRS

    #
    # @param {Hash} opts
    #
    # SCOPE opts
    #   @param {String}         origin            [optional] part of payloadID
    #   @param {String|Number}  status_code       should be a valid number
    #   @param {String}         status_text       [optional]
    #   @param {String}         start_page_url
    #
    def initialize opts
      validate_opts! opts
      assign_opts opts
    end


    def self.parse(xml)
      data = CXML.parse(xml)

      status = data["Response"]["Status"]

      status_code = status["code"].to_i
      raise PunchoutSetupResponseError, "status_code=#{ status_code } is not valid" unless status_code.to_s == status["code"].to_s
      status_text = status["text"]

      start_page_url = data["Response"]["PunchOutSetupResponse"]["StartPage"]["URL"]

      PunchoutSetupResponse.new({
        status_code:     status_code,
        status_text:     status_text,
        start_page_url:  start_page_url
      })
    end


    def render
      raise ArgumentError, "no origin specified" unless origin

      document = Document.new(origin: origin)
      document.setup

      document.response = Response.new({
        status_code: status_code, 
        status_text: status_text,

        payload:     PunchoutSetupResponseNode.new(start_page_url: start_page_url)
      })

      document.render
    end


    def to_xml
      render.to_xml
    end

    private

    def validate_opts! opts
      code = opts[:status_code]
      if code.is_a?(String) && code.to_i.to_s != code
        raise ArgumentError, "status_code=#{ code } is not valid ingeger" 
      end

      url = opts[:start_page_url]
      raise ArgumentError, "start_page_url='#{ url }' is not a String" unless url.is_a? String
    end


    def assign_opts opts
      ATTRS.each { |opt| instance_variable_set(:"@#{ opt }", opts[opt]) }
    end

  end
end
