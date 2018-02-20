
module CXML
  class PunchoutSetupRequestNode
    ATTRS = [
      :operation,
      :buyer_cookie,

      :browser_form_post_url,
      :supplier_setup_url,
      :user,

      :ship_to 
    ]

    attr_reader *ATTRS

    def initialize opts
      validate_opts!  opts
      assign_opts     opts
    end

    def render node
      node.Request do |n|
        n.PunchOutSetupRequest("operation" => operation) do |n|
          n.BuyerCookie buyer_cookie
          user.render(n) unless user.nil?

          n.BrowserFormPost do |n|
            n.URL browser_form_post_url
          end

          n.SupplierSetup do |n|
            n.URL supplier_setup_url
          end

          unless ship_to.nil?
            n.ShipTo { |n| ship_to.render(n) }
          end
        end
      end
    end

    private

    def validate_opts! opts
      raise ArgumentError, "operation='#{ opts[:operation] }' is not a Symbol" unless opts[:operation].is_a? Symbol

      [ :buyer_cookie, :browser_form_post_url, :supplier_setup_url ].each do |opt|
        raise ArgumentError, "#{opt}='#{ opts[opt] }' is not a String" unless opts[opt].is_a? String
      end

      [ 
        [ :user,    User ], 
        [ :ship_to, Address ] 
      ].each do |pair|
        opt, klass = pair
        if !opts[opt].nil? && !opts[opt].is_a?(klass)
          raise ArgumentError, "#{ opt }='#{ opts[opt] }' is not a CXML::#{ klass.name }"
        end
      end
    end

    def assign_opts opts
      ATTRS.each do |opt|
        instance_variable_set(:"@#{opt}", opts[opt])
      end
    end
  end
end
