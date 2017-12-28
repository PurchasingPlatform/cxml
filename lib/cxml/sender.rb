module CXML
  class Sender
    attr_reader :credential, :user_agent

    def initialize(data = {})
      @credential = CXML::Credential.new(data['Credential'])
      @user_agent = data['UserAgent']
    end

    def render
      node = Ox::Element.new('Sender')
      node << Ox::Element.new('UserAgent')
      node.UserAgent << user_agent.to_s
      node << credential.render
      node
    end
  end
end
