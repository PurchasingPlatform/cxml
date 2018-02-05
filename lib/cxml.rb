require "cxml/version"
require "cxml/errors"
require "time"
require "securerandom"
require "nokogiri"

module CXML
  autoload :Protocol,                  "cxml/protocol"
  autoload :UserAgent,                 "cxml/user_agent"
  autoload :Document,                  "cxml/document"
  autoload :Header,                    "cxml/header"
  autoload :Credential,                "cxml/credential"
  autoload :Sender,                    "cxml/sender"
  autoload :Status,                    "cxml/status"
  autoload :Request,                   "cxml/request"
  autoload :Response,                  "cxml/response"
  autoload :OrderMessage,              "cxml/order_message"
  autoload :Money,                     "cxml/money"
  autoload :Item,                      "cxml/item"
  autoload :Parser,                    "cxml/parser"
  autoload :User,                      "cxml/user"
  autoload :PunchoutSetupRequestError, "cxml/punchout_setup_request_error"
  autoload :PunchoutSetupRequestNode,  "cxml/punchout_setup_request_node"
  autoload :PunchoutSetupRequest,      "cxml/punchout_setup_request"

  def self.parse(str)
    CXML::Parser.new.parse(str)
  end

  def self.builder
    Nokogiri::XML::Builder.new(encoding: "UTF-8")
  end
end
