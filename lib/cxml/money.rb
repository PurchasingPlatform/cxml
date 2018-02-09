# The Money element has three possible attributes: currency, alternateAmount,
# alternateCurrency. The attributes currency and alternateCurrecy must be a three-letter ISO
# 4217 currency code. The content of the Money element and of the aternateAmount
# attribute should be a numeric value. For example:
# <Money currency="USD">12.34</Money>
# The optional alternateCurrency and alternateAmount attributes are used together to specify
# an amount in an alternate currency. These can be used to support dual-currency
# requirements such as the euro. For example:
# <Money currency="USD" alternateCurrency=”EUR” alternateAmount=”14.28”>12.34
# </Money>
# Note:  You can optionally use commas as thousands separators. Do not use
# commas as decimal separators.
#
# Page: 59

module CXML
  class Money
    attr_accessor :currency
    attr_accessor :amount
    attr_accessor :alternative_currency
    attr_accessor :alternative_amount

    def initialize opts = nil
      opts ||= {}
      @raw = opts[:raw]
    end 

    def amount
      @amount ||= raw["content"].to_f
    end

    def currency
      @currency ||= raw["currency"]
    end

    def render(node)
      node.Money(amount, build_attributes)
    end

    private

    def raw
      @raw
    end

    def build_attributes
      attributes = {}
      attributes[:currency] = currency
      attributes[:alternateCurrency] = alternative_currency if alternative_currency
      attributes[:alternateAmount] = alternative_amount if alternative_amount
      attributes
    end
  end
end
