module DynamicLinks
  class Configuration
    attr_accessor :forbidden_keywords, :root, :default_expiry, :sublink_length, :hash_salt

    def initialize
      # TODO - get forbidden keywords from yml file
      @forbidden_keywords = %w[fuck muck suck dick cock]
      @root = "dl"
      @default_expiry = Date.tomorrow
      @sublink_length = 2
      @hash_salt = "dynamic links"
    end
  end
end