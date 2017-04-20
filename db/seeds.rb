class Artist < ActiveRecord::Base
list = [
    "Lady Gaga" , "Snoop Dogg" , "Jay Z" , "Kanye West", "Ching Chong" , "Adam Bayer" , "David Guetta"
  ]

  list.each do |name|
    Artist.create( name: name )
  end
end

class Category < ActiveRecord::Base
list = [
    "Techno and House" , "Hip Hop" , "Basketball" , "Football", "Musical" , "Opera" , "Circus"
  ]

  list.each do |name|
    Category.create( name: name )
  end
end

class Venue < ActiveRecord::Base
list = [
    ["Dragon i", "The Centrium, 60 Wyndham St, Central", "http://www.dragon-i.com.hk/img/logo.png"] ,
    ["Cyberport", "100 Cyberport Rd, Telegraph Bay", "https://uchicago.hk/sites/hongkong.uchicago.edu/files/styles/extra-wide/public/uploads/images/cyberport.jpg?itok=lK4vvTqU"] ,
    ["Central Harbourfront", "Lung Wo Rd, Central", "http://www.winebuzz.hk/wp-content/uploads/2013/07/hkwineanddinefestival.jpg"] ,
    ["Tamar Park", "Harcourt Rd, Admiralty", "https://i.ytimg.com/vi/Ah9MCcGwc3c/maxresdefault.jpg"],
    ["IFC", "8 Finance Street, Central", "https://upload.wikimedia.org/wikipedia/commons/7/78/IFC_HKSAR.JPG"] ,
    ["Secret", "secret", "http://kingofwallpapers.com/secret/secret-004.jpg"],
    ["Lan Kwai Fong", "Lan Kwai Fong, Central", "http://monipag.com/valentin-hastoy/wp-content/uploads/sites/1663/2015/12/OB-LP879_lkf_F_20110105053247.jpg"]
  ]

  list.each do |name, address, imageurl|
    Venue.create( name: name , address: address, imageurl: imageurl)
  end
end
