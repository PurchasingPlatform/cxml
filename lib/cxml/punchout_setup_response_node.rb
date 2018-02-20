module CXML
  class PunchoutSetupResponseNode

    attr_reader :start_page_url

    # 
    # @param {Hash} opts
    #
    # SCOPE opts
    #   @param { String } start_page_url
    #
    def initialize opts
      unless opts[:start_page_url].is_a? String
        raise ArgumentError, "start_page_url='#{ opts[:start_page_url] }' is not a String" 
      end

      @start_page_url = opts[:start_page_url]
    end

    def render(node)
      node.PunchOutSetupResponse do |n|
        n.StartPage do |n|
          n.URL(start_page_url)
        end
      end
    end
  end
end
