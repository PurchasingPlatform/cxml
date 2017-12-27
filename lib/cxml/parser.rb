module CXML
  class Parser
    def parse(data)
      # XmlSimple.xml_in(data, {"ForceArray" => false})
      Ox.load(data, mode: :hash)
    end
  end
end
