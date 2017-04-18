class User < ActiveRecord::Base
  has_many :events, through: :offers
  has_many :offers, dependent: :destroy
end
