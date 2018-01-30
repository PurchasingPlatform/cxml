module CXML
  class OrderMessage
    attr_accessor :buyer_cookie, :allowed_operation, :total, :items

    def render(node)
      node.Message do |msg|
        msg.PunchOutOrderMessage do |pom|
          pom.BuyerCookie(buyer_cookie) if buyer_cookie
          pom.PunchOutOrderMessageHeader(operationAllowed: allowed_operation) do |pomh|
            pomh.Total { total.render(node) }
          end
          items.each { |item| item.render(node) }
        end
      end
    end
  end
end
