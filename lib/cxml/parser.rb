module CXML
  class Parser
    def parse(data)
      Ox.load(data, mode: :hash, symbolize_keys: false)
    end
  end
end
