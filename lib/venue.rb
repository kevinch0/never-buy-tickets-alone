class Venue < ActiveRecord::Base
  has_many :events

  define_singleton_method(:arr) do
    arr = []
    venue = Venue.all()
    venue.each() do |v|
      arr.push(v.address)
    end
    arr
  end

end
