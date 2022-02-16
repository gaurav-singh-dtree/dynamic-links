module DynamicLinks
  class Configuration
    attr_accessor :forbidden_keywords, :root, :default_expiry, :sublink_length, :hash_salt

    def initialize
      @forbidden_keywords = File.read("#{__dir__}/../data/words.txt").split(',').map(&:strip)
      @root = "dl"
      @default_expiry = Date.tomorrow
      @sublink_length = 2
      @hash_salt = "dynamic links"
    end
  end
end
