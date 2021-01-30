module DynamicLinks
  class Configuration
    attr_accessor :forbidden_keywords, :subdomain, :default_expiry, :sublink_length, :hash_salt

    def initialize
      # TODO - get forbidden keywords from yml file
      @forbidden_keywords = %w[fuck muck suck]
      @subdomain = "dl"
      @default_expiry = Date.tomorrow
      @sublink_length = 2
      @hash_salt = "dynamic links"
    end
  end
end