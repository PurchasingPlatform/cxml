module CXML
  #
  # Complete PunchoutSetupRequest document
  #
  class PunchoutSetupRequest
    CREATE_ATTRS = [ 
      :origin,
      :operation,
      :from, :to, 
      :shared_secret, 
      :browser_form_post_url, :supplier_setup_url, 
      :user,
      :ship_to
    ]

    attr_reader *CREATE_ATTRS, :buyer_cookie
    attr_writer :origin

    #
    # @param {Hash} otps
    #
    # SCOPE opts
    #   @param {Symbol} operation = :create, ... other not implemented
    #
    #   SCOPE opts.operation == :create
    #   @param {Credential}       from
    #   @param {Credential}       to
    #   @param {String}           shared_secret
    #
    #   @param {String}           browser_form_post_url
    #   @param {String}           supplier_setup_url
    #
    #   @param {Transform::User}  user
    #
    def initialize opts
      validate_create_opts! opts
      assign_create_opts opts
      generate_buyer_cookie
    end

    def request_opts
      {
        operation:             operation,
        buyer_cookie:          buyer_cookie,
        browser_form_post_url: browser_form_post_url,
        supplier_setup_url:    supplier_setup_url,
        user:                  user,
        ship_to:               ship_to
      }
    end

    def render
      raise ArgumentError, ":origin not specified" unless origin

      document = Document.new(origin: origin)
      document.setup
      
      document.header = Header.new({
        from:   from,
        to:     to,
        sender: Sender.new(credential: from.with(shared_secret: shared_secret))
      }) 

      document.request = PunchoutSetupRequestNode.new(request_opts)

      document.render
    end

    def to_xml
      render.to_xml
    end

    private

    def validate_create_opts! opts
      raise ArgumentError, "Unsupported operation '#{ opts.operation }'" if opts[:operation] != :create

      [:from, :to].each do |opt|
        raise ArgumentError, "#{ opt }='#{ opts[opt] }' is not a CXML::Credential" unless opts[opt].is_a? Credential
      end 

      [:browser_form_post_url, :supplier_setup_url].each do |opt|
        raise ArgumentError, "#{ opt }='#{ opts[opt] }' is not a String" unless opts[opt].is_a? String
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

    def assign_create_opts opts
      CREATE_ATTRS.each do |opt|
        instance_variable_set(:"@#{opt}", opts[opt])
      end
    end

    def generate_buyer_cookie
      @buyer_cookie = SecureRandom.hex(16)
    end
  end
end
