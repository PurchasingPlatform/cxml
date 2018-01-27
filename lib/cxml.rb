require "cxml/version"
require "cxml/errors"
require "time"
require "nokogiri"

module CXML
  autoload :Protocol,      "cxml/protocol"
  autoload :Document,      "cxml/document"
  autoload :Header,        "cxml/header"
  autoload :Credential,    "cxml/credential"
  autoload :Sender,        "cxml/sender"
  autoload :Status,        "cxml/status"
  autoload :Request,       "cxml/request"
  autoload :Response,      "cxml/response"
  autoload :OrderMessage,  "cxml/order_message"
  autoload :Money,         "cxml/money"
  autoload :Item,          "cxml/item"
  autoload :Parser,        "cxml/parser"

  def self.parse(str)
    CXML::Parser.new.parse(str)
  end

  def self.builder
    Nokogiri::XML::Builder.new(encoding: "UTF-8")
  end
end
