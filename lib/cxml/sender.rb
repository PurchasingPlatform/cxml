module CXML
  class Sender
    attr_reader :credential, :user_agent

    def initialize(data = {})
      @credential = CXML::Credential.new(data['Credential'])
      @user_agent = data['UserAgent']
    end

    def render(node)
      # node.Sender do |n|
      #   n.UserAgent(user_agent)
      #   credential.render(n)
      # end
      # node

      node << Ox::Element.new('Sender')
      node.Sender << Ox::Element.new('UserAgent')
      node.Sender.UserAgent << user_agent.to_s
      node.Sender << credential.render(node.Sender)
    end
  end
end
