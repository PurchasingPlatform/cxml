module CXML
  class PunchoutOrderMessageItem
    attr_reader :supplier_part_id, :supplier_part_auxiliary_id, 
      :unit_price, :quantity, :unit_of_measure,
      :description, :classifictaion_unspsc

    def initialize opts
      @raw = opts[:raw]
    end

    def supplier_part_id
      raw["ItemID"]["SupplierPartID"]
    end

    def supplier_part_auxiliary_id
      raw["ItemID"]["SupplierPartAuxiliaryID"]
    end

    def unit_price
      Money.new(raw: raw["ItemDetail"]["UnitPrice"]["Money"])
    end

    def quantity
      raw["quantity"].to_i
    end

    def unit_of_measure
      raw["ItemDetail"]["UnitOfMeasure"]
    end

    def description
      raw["ItemDetail"]["Description"]["content"]
    end

    def classifictaion_unspsc
      classification = raw["ItemDetail"]["Classification"]
      return unless classification["domain"] == "UNSPSC"

      classification["content"]
    end

    private

    def raw
      @raw
    end
  end
end
