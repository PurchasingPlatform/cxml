module CXML
  # Clients send requests for operations. Only one Request element is allowed
  # for each cXML envelope element, which simplifies the server implementations,
  # because no demultiplexing needs to occur when reading cXML documents.
  # The Request element can contain virtually any type of XML data.
  class Request
    attr_reader :id, :deployment_mode

    def initialize(data = {})
      @id = data.deep_locate('id')
      @deployment_mode = data.deep_locate('deploymentMode')
    end
  end
end
