class ArtistsEvent < ActiveRecord::Base
  belongs_to :event
  belongs_to :artist
end
