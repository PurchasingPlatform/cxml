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
      :user
    ]

    attr_reader *CREATE_ATTRS, :buyer_cookie

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
        user:                  user
      }
    end

    def render
      document = Document.new(origin: origin)
      document.setup
      
      document.header = CXML::Header.new({
        from:   from,
        to:     to,
        sender: Sender.new(credential: from.with(shared_secret: shared_secret))
      }) 

      document.request = PunchoutSetupRequestNode.new(request_opts)

      document.render
    end

    private

    def validate_create_opts! opts
      raise ArgumentError, "Unsupported operation '#{ opts.operation }'" if opts[:operation] != :create

      raise ArgumentError, ":origin not specified" unless opts[:origin]

      [:from, :to].each do |opt|
        raise ArgumentError, "#{ opt }='#{ opts[opt] }' is not a CXML::Credential" unless opts[opt].is_a? Credential
      end 

      [:browser_form_post_url, :supplier_setup_url].each do |opt|
        raise ArgumentError, "#{ opt }='#{ opts[opt] }' is not a String" unless opts[opt].is_a? String
      end

      raise ArgumentError, "user='#{ opts[:user] }' is not a CXML::User" unless opts[:user].is_a? User
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
