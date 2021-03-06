# The Header element contains addressing and authentication information. The Header
# element is the same regardless of the specific Request or Response within the body of 
# the cXML message. Applications need the requestor"s identity, but not validation that 
# the information provided for identity is correct.
# 
# The From and To elements are synonymous with From and To in SMTP mail 
# messages; they are the logical source and destination of the messages. Sender is the 
# party that opens the HTTP connection and sends the cXML document.
# Sender contains the Credential element, which allows the receiving party to authenticate 
# the sending party. This credential allows strong authentication without requiring a 
# public-key end-to-end digital certificate infrastructure. Only a user name and 
# password need to be issued by the receiving party to allow the sending party to 
# perform Requests.
#
# When the document is initially sent, Sender and From are the same, However, if the 
# cXML document travels through e-commerce network hubs, the Sender element 
# changes to indicate current sending party.

module CXML
  class Header
    attr_accessor :from, :to, :sender

    def initialize(data=nil)
      data ||= {}

      from_credential = data["From"]["Credential"]    if data["From"]
      to_credential   = data["To"]["Credential"]      if data["To"]

      @from   = CXML::Credential.new(from_credential) if from_credential
      @to     = CXML::Credential.new(to_credential)   if to_credential
      @sender = CXML::Sender.new(data["Sender"])      if data["Sender"]

      @from   ||= data[:from]
      @to     ||= data[:to]
      @sender ||= data[:sender]
    end

    def render(node)
      node.From   { |n| from.render(n) }
      node.To     { |n| to.render(n) }

      sender.render(node)
      node
    end
  end
end
