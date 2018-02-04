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

    def render(node)
      node.Sender do |n|
        n.UserAgent(user_agent)
        credential.render(n)
      end
      node
    end
  end
end
