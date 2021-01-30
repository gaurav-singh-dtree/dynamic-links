require 'hashids'

class DynamicLinks::DynamicLink < ApplicationRecord
  include Rails.application.routes.url_helpers

  serialize :link_data
  validates_presence_of :link_key, :hostname
  validates :link_key, uniqueness: true
  validate :valid_link_attributes


  scope :not_expired , -> { where("expires_at IS NULL OR expires_at > ?", Time.now)}
  scope :active, -> { where(active: true)}

  def self.generate(hostname:, custom_prefix: nil, expires_at: nil, options: nil, about: nil, force_new: false)
    link = get_or_create_link(
      hostname: hostname,
      custom_prefix: custom_prefix,
      expires_at: expires_at,
      options: options,
      about: about,
      force_new: force_new
    )
    if link.valid?
      link.generate_link
    else
      build_error
    end
  end

  def self.fetch_link(key)
    not_expired.active.find_by(link_key: key)
  end

  def build_redirect_link
    if query_param = build_query_params_from_utm
      "#{build_redirect_link_from_data_attributes}#{query_param}"
    else
      "#{build_redirect_link_from_data_attributes}"
    end
  end

  def generate_link
    # TODO - refactor
    "#{self.hostname}/#{DynamicLinks.configuration.subdomain}/#{self.link_key}"
  end

  def valid_link?
    active? && !expired?
  end

  def expired?
    expires_at < Time.now
  end

  private

  def self.get_or_create_link(hostname:, custom_prefix: nil, expires_at: nil, options: nil, about: nil, force_new: false)
    if force_new
      link = create(
        hostname: hostname,
        link_data: options,
        link_key: generate_key(custom_prefix),
        expires_at: expires_at,
        about: about
      )
    else
      link = find_or_create_by(hostname: hostname, link_data: options) do |dynamic_link|
        dynamic_link.expires_at = expires_at
        dynamic_link.link_key = generate_key(custom_prefix)
        dynamic_link.about = about
      end
    end
  end

  def build_redirect_link_from_data_attributes
    link = if link_data[:link]
      "#{hostname}#{link_data[:link]}"
    elsif link_data[:action]
      data = link_data
      data[:host] = hostname
      url_for(data)
    end
  end

  def build_query_params_from_utm
    utm_query_params = []
    final_query_params = nil
    utm_keys = link_data.keys.select{ |v| v.to_s.start_with?('utm') }
    utm_keys.each do |key|
      utm_query_params << "#{key}=#{link_data[key]}"
    end
    final_query_params = utm_query_params.join("&") if utm_query_params.present?
    if final_query_params
      return "?#{final_query_params}"
    end
  end

  def self.generate_key(custom_prefix)
    hashid = Hashids.new(
      DynamicLinks.configuration.hash_salt,
      DynamicLinks.configuration.sublink_length
    )
    link_id = hashid.encode((self.last&.id || 0) + 1)
    custom_prefix.present? ? "#{custom_prefix}-#{link_id}" : link_id
  end

  def valid_link_attributes
    if !valid_host?
      self.errors.add(:hostname, "Invalid Host")
    end
    if !valid_expiry_date?
      self.errors.add(:expires_at, "Invalid Expiry Date")
    end
    if !valid_link_key?
      self.errors.add(:link_key, "Invalid Custom Name")
    end
  end

  def valid_host?
    uri = URI.parse(hostname)
    uri.is_a?(URI::HTTP) && !uri.host.nil?
  rescue URI::InvalidURIError
    false
  end

  def valid_link_key?
    DynamicLinks.configuration.forbidden_keywords.reduce(true) do |val, keyword|
      val = (val && !link_key.include?(keyword))
    end
  end

  def valid_expiry_date?
    expires_at > Time.now
  end

  def build_error
    errors = []
    link.errors.each do |attribute, error|
      errors << error
    end
    { error: errors.join(',') }
  end
end
