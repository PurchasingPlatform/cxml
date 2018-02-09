module CXML
  class Sender
    attr_reader :credential, :user_agent

    DEFAULT_USER_AGENT = UserAgent.info

    def initialize(data=nil)
      data ||= {}

      @credential = CXML::Credential.new(data["Credential"])  if data["Credential"]
      @user_agent = data["UserAgent"]                         if data["UserAgent"]

      @credential = data[:credential]                         unless @credential
      @user_agent = data[:user_agent] || DEFAULT_USER_AGENT   unless @user_agent
    end

    def domain
      credential.domain
    end

    def identity
      credential.identity
    end

    def shared_secret
      credential.shared_secret
    end

    def render(node)
      node.Sender do |n|
        credential.render(n)
        n.UserAgent(user_agent)
      end
      node
    end
  end
end
