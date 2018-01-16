# Servers send responses to inform clients of the results of operations. Because the
# result of some requests might not have any data, the Response element can optionally
# contain nothing but a Status element. A Response element can also contain any
# application-level data. During PunchOut for example, the application-level data is
# contained in a PunchOutSetupResponse element.

module CXML
  class Response
    attr_accessor :id, :status, :punchout_setup_url

    def initialize(data=nil)
      data ||= {}
      @status = CXML::Status.new(data["Status"])
    end

    def render(node)
      options = {}
      options[:id] = id if id

      node.Response(options) { |n| status.render(n) }

      if punchout_setup_url
        node.Response do |r|
          r.PunchOutSetupResponse do |p|
            p.StartPage do |s|
              s.URL(punchout_setup_url)
            end
          end
        end
      end

      node
    end
  end
end
