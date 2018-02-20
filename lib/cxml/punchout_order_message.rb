module CXML
  class PunchoutOrderMessage
    attr_accessor :header

    def initialize opts
      @raw    = opts[:raw]
      @header = opts[:header]
    end

    def self.parse(xml)
      data = CXML.parse(xml)

      PunchoutOrderMessage.new({
        raw: data,
        header: CXML::Header.new(data["Header"]),
        buyer_cookie: data["BuyerCookie"],
      })
    end

    def buyer_cookie
      message["BuyerCookie"]
    end

    def total
      Money.new(raw: message["PunchOutOrderMessageHeader"]["Total"]["Money"])
    end

    def total_currency
      message["PunchOutOrderMessageHeader"]["Total"]["Money"]["currency"]
    end

    def items
      if @items.nil?
        items  = message["ItemIn"]
        items  = [ items ] unless items.is_a? Array
        @items = items.map { |item| PunchoutOrderMessageItem.new(raw: item) }
      end
      @items
    end

    private

    def raw
      @raw
    end

    def message
      raw["Message"]["PunchOutOrderMessage"]
    end
  end
end
