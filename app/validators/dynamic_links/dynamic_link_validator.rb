class DynamicLinks::DynamicLinkValidator < ActiveModel::Validator
  def validate(record)
    if !valid_host?(record)
      record.errors.add(:hostname, "Invalid Host")
    end
    if !valid_expiry_date?(record)
      record.errors.add(:expires_at, "Invalid Expiry Date")
    end
    if !valid_link_key?(record)
      record.errors.add(:link_key, "Invalid Custom Name")
    end
  end

  def valid_host?(record)
    uri = URI.parse(record.hostname)
    uri.is_a?(URI::HTTP) && !uri.host.nil?
  rescue URI::InvalidURIError
    false
  end

  def valid_link_key?(record)
    DynamicLinks.configuration.forbidden_keywords.reduce(true) do |val, keyword|
      val = (val && !record.link_key.include?(keyword))
    end
  end

  def valid_expiry_date?(record)
    if record.expires_at
      record.expires_at > Time.now
    else
      true
    end
  end
end