class Artist < ActiveRecord::Base
  has_many :events, through: :artists_events
  has_many :artists_events, dependent: :destroy
end
