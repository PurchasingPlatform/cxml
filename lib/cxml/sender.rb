module CXML
  class Sender
    attr_reader :credential, :user_agent

    def initialize(data={})
      @credential = CXML::Credential.new(data["Credential"])
      @user_agent = data["UserAgent"]
    end

    def render(node)
      node.Sender do |n|
        n.UserAgent(user_agent)
        credential.render(n)
      end
      node
    end
  end
end