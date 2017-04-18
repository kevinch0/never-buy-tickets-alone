class Event < ActiveRecord::Base
  has_many :artists, through: :artists_events
  has_many :artists_events, dependent: :destroy
  has_many :users, through: :offers
  has_many :offers, dependent: :destroy
  belongs_to :category
  belongs_to :venue
end
