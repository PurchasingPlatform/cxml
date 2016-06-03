# Servers send responses to inform clients of the results of operations. Because the
# result of some requests might not have any data, the Response element can optionally
# contain nothing but a Status element. A Response element can also contain any
# application-level data. During PunchOut for example, the application-level data is
# contained in a PunchOutSetupResponse element.

module CXML
  class Response
    attr_accessor :id
    attr_reader :status

    def initialize(data={})
      @status = CXML::Status.new(data["Status"])
    end

    def render(node)
      options = {}
      options.merge!(id: id) if id

      node.Response(options) { |n| status.render(n) }
    end
  end
end