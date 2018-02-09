module CXML
  class Address

    STRING_ATTRS = %i[  id  to  street  city  state  postal_code  ]

    attr_reader *STRING_ATTRS, :country

    #
    # @param {Hash} opts
    #
    # SCOPE opts
    #   @param {String} id
    #   @param {String} to  - name of recepient
    #   @param {String} street
    #   @param {String} city
    #   @param {String} postal_code
    #   @param {Hash<iso_code, name>} country   - example { iso_code: "US", name: "United States" }
    #
    def initialize opts
      validate_opts! opts
      assign_opts opts
    end

    def render(node)
      node.Address(addressID: id) do |n|
        n.Name(id, "xml:lang" => "en")
        n.PostalAddress do |n|
          n.DeliverTo   to
          n.Street      street
          n.City        city
          n.State       state
          n.PostalCode  postal_code
          n.Country(country[:name], isoCountryCode: country[:iso_code])
        end
      end
    end

    private

    def validate_opts! opts
      STRING_ATTRS.each do |opt|
        raise ArgumentError, "#{opt}=#{ opts[opt] } is not String"    unless opts[opt].is_a? String
      end

      raise ArgumentError, "country=#{ opts[:country] } is not Hash"  unless opts[:country].is_a? Hash
    end

    def assign_opts opts
      STRING_ATTRS.each { |opt| self.instance_variable_set(:"@#{opt}", opts[opt]) }
      @country = opts[:country]
    end

  end
end
