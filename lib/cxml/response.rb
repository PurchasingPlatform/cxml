# Servers send responses to inform clients of the results of operations. Because the
# result of some requests might not have any data, the Response element can optionally
# contain nothing but a Status element. A Response element can also contain any
# application-level data. During PunchOut for example, the application-level data is
# contained in a PunchOutSetupResponse element.

module CXML
  class Response
    attr_accessor :id, :status, :payload, :punchout_setup_url

    def initialize(data=nil)
      data ||= {}

      status_opts = data["Status"]
      unless status_opts
        status_opts = {
          code: data[:status_code],
          text: data[:status_text]
        }
      end

      @status = Status.new(status_opts)
      @payload = data[:payload]
    end

    def render(node)
      options = {}
      options[:id] = id if id

      node.Response(options) do |n|
        status.render(n)
        payload.render(n) if payload

        if punchout_setup_url
          n.PunchOutSetupResponse do |p|
            p.StartPage do |s|
              s.URL(punchout_setup_url)
            end
          end
        end
      end
    end
  end
end
