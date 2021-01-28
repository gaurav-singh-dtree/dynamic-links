require 'hashids'

class DynamicLinks::DynamicLink < ApplicationRecord
  include Rails.application.routes.url_helpers

  serialize :link_data
  validates_presence_of :link_key, :hostname
  validates :link_key, uniqueness: true

  scope :not_expired , -> { where("expires_at IS NULL OR expires_at > ?", Time.now)}

  def self.generate(hostname:, custom_name: nil, expires_at: nil, options: nil, about: nil)
    # TODO - refactor
    link = find_or_create_by!(hostname: hostname, link_data: options) do |dynamic_link|
      dynamic_link.expires_at = expires_at
      dynamic_link.link_key = generate_key(custom_name)
      dynamic_link.about = about
    end
    link.generate_link
  end

  def self.fetch_link(key)
    not_expired.find_by(link_key: key)
  end

  def build_redirect
    # TODO - refactor
    if link_data[:link]
      "#{hostname}#{link_data[:link]}"
    elsif link_data[:action]
      data = link_data
      data[:host] = hostname
      url_for(data)
    else
    end
  end

  def generate_link
    # TODO - refactor
    "#{self.hostname}/dl/#{self.link_key}"
  end

  private

  def self.generate_key(custom_name)
    hashid = Hashids.new
    link_id = hashid.encode((self.last&.id || 0) + 1)
    custom_name.present? ? "#{custom_name}-#{link_id}" : link_id
  end
end
