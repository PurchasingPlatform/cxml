module CXML
  class Item
    attr_accessor :qty, :supplier_id, :supplier_auxiliary_id,
                  :unit_price, :description, :unit_of_measure,
                  :unspsc, :lang, :name

    def render(node)
      node.ItemIn(quantity: qty) do
        node.ItemID do
          node.SupplierPartID(supplier_id)
          node.SupplierPartAuxiliaryID(supplier_auxiliary_id)
        end

        node.ItemDetail do
          node.UnitPrice { unit_price.render(node) }
          node.Description(description, 'xml:lang' => lang) do
            node.ShortName(name)
          end
          node.UnitOfMeasure(unit_of_measure)
          node.Classification(unspsc, domain: 'UNSPSC') unless unspsc.nil?
        end
      end
    end
  end
end
