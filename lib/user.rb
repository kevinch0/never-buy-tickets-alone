class User < ActiveRecord::Base
  has_many :events, through: :offers
  has_many :offers, dependent: :destroy
  validates :username, presence: true
  validates :username, uniqueness: { case_sensitive: false }
end
