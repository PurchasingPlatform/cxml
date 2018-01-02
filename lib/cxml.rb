require 'cxml/version'
require 'cxml/errors'
require 'hashie'
require 'time'
require 'ox'

class Hash
  include Hashie::Extensions::DeepLocate
end

# Ruby library to work with the cXML protocol
module CXML
  autoload :Protocol,   'cxml/protocol'
  autoload :Document,   'cxml/document'
  autoload :Header,     'cxml/header'
  autoload :Credential, 'cxml/credential'
  autoload :Sender,     'cxml/sender'
  autoload :Status,     'cxml/status'
  autoload :Request,    'cxml/request'
  autoload :Response,   'cxml/response'
  autoload :Parser,     'cxml/parser'

  def self.parse(str)
    CXML::Parser.new.parse(str)
  end

  def self.builder
    Ox::Document.new(version: '1.0', encoding: 'UTF-8')
  end
end
