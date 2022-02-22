class DynamicLinks::Tracker < ApplicationRecord
  validates_presence_of :remote_ip
end