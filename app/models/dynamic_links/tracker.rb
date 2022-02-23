class DynamicLinks::Tracker < ApplicationRecord
  validates_presence_of :remote_ip
  validates :remote_ip, format: { with: /\A((25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\z/, message: "Invalid IP" }
  validates :ip, format: { with: /\A((25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\z/, message: "Invalid IP" }
  validates :http_origin, format: { with: /\A((25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\z/, message: "Invalid Origin" }
  valid :user_agent, 
end