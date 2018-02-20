module CXML
  class User
    attr_reader :email, :unique_name

    def initialize opts
      validate_opts! opts

      @email        = opts[:email]
      @unique_name  = opts[:unique_name] || @email
    end

    def render node
      node.Extrinsic(email,       "name" => "UserEmail")
      node.Extrinsic(unique_name, "name" => "UniqueName")
    end

    private

    def validate_opts! opts
      raise ArgumentError, "email='#{opts[:email]}' is not a String" unless opts[:email].is_a? String
    end
  end
end
