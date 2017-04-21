require("bundler/setup")
require('pg')
require('bcrypt')
require('rickshaw')
require('rack')
require "sinatra/reloader"
require('pry')

Bundler.require(:default)

Dir[File.dirname(__FILE__) + '/lib/*.rb'].each { |file| require file }
also_reload("lib/*.rb")

# authentication
configure do
  enable :sessions
end

register do
  def auth (type)
    condition do
      redirect "/" unless send("is_#{type}?")
    end
  end
end

helpers do
  def is_user?
    @user != nil
  end
end

before do
  if session[:id] == nil
    @user = nil
  else
    @user = User.find(session[:id])
  end
end

#main_pages

get('/') do
  erb(:index)
end

get '/admin', :auth => :user do
  @categories = Category.all()
  @events= Event.all()
  @venues= Venue.all()
  @artists=Artist.all()
  @offers=Offer.all()
  redirect ('/user') if @user.username !="admin"
  erb(:admin)
end

get "/signup" do
  erb(:signup)
end

post('/signup') do
  password = params.fetch('password').to_sha1()
  username = params.fetch('username')
  @user = User.new({:username => username, :password => password})
  if @user.save()
    session[:id] = @user.id
    redirect ('/admin') if username == "admin"
    redirect ('/user')
  else
    redirect ('signup')
  end
end

get "/login" do
  erb(:login)
end

post "/login" do
  username= params.fetch('username')
  password = params.fetch("password").to_sha1()
  @user = User.find_by(username: username, password: password)

  if @user != nil
    session[:id] = @user.id()
    redirect ('/admin') if username == "admin"
    redirect ('/user')
  else
    redirect ('/login')
  end
end

get "/user", :auth => :user do
  @categories = Category.all()
  @events= Event.all()
  @venues= Venue.all()
  @artists=Artist.all()
  @offers=Offer.all()
  redirect ('/admin') if @user.username == "admin"
  erb(:user)
end

get "/logout" do
  session.clear
  redirect "/"
end

get('/events') do
  @categories = Category.all()
  @events= Event.all()
  @venues= Venue.all()
  @artists=Artist.all()
  erb(:events)
end

post ('/event') do
  name = params.fetch('name')
  date = params.fetch('date')
  duration = params.fetch('duration')
  imageurl = params.fetch('imageurl')
  artist_name = params.fetch('artist_name')
  category_name = params.fetch('category_name')
  venue_name = params.fetch('venue_name')
  yo = params.fetch('yo').to_i()
  if yo==2
    venue_image = params.fetch('venue_image')
    venue_address = params.fetch('venue_address')
  end
  artist = Artist.where(:name => artist_name).first_or_create(:name => artist_name)

  category = Category.where(:name => category_name).first_or_create(:name => category_name)

  venue = Venue.where(:name => venue_name).first_or_create(:name => venue_name, :imageurl => venue_image, :address => venue_address)

  event = Event.create({:name => name, :date => date, :duration => duration, :imageurl => imageurl, :venue => venue, :category => category})

  ArtistsEvent.create(event: event, artist: artist)

  if event.save()
    redirect ('/admin')
  else
    erb(:errors)
  end
end

get('/event/:id') do
  @event=Event.find(Integer(params.fetch('id')))
  erb(:event)
end

patch("/event/:id") do
  event_id=Integer(params.fetch('id'))
  name = params.fetch("name")
  date = params.fetch("date")
  imageurl = params.fetch("imageurl")
  @event = Event.find(params.fetch("id").to_i())
  @event.update({:name => name, :date => date, :imageurl => imageurl})
  redirect("/event/#{event_id}")
end

delete("/event/:id") do
  event_id=Integer(params.fetch("id"))
  event_to_be_deleted= Event.find(event_id)
  event_to_be_deleted.destroy()
  redirect("/admin")
end

get('/artist/:id') do
  @artist=Artist.find(Integer(params.fetch('id')))
  erb(:artist)
end

patch("/artist/:id") do
  artist_id=Integer(params.fetch('id'))
  name = params.fetch("name")
  @artist = Artist.find(params.fetch("id").to_i())
  @artist.update({:name => name})
  redirect("/artist/#{artist_id}")
end


delete("/artist/:id") do
  artist_id=Integer(params.fetch("id"))
  artist_to_be_deleted= Artist.find(artist_id)
  artist_to_be_deleted.destroy()
  redirect("/admin")
end

get('/venue/:id') do
  @venue=Venue.find(Integer(params.fetch('id')))
  erb(:venue)
end

patch("/venue/:id") do
  venue_id=Integer(params.fetch('id'))
  name = params.fetch("name")
  address = params.fetch('address')
  imageurl = params.fetch('imageurl')
  @venue = Venue.find(params.fetch("id").to_i())
  @venue.update({:name => name, :address => address, :imageurl => imageurl})
  redirect("/venue/#{venue_id}")
end


delete("/venue/:id") do
  venue_id=Integer(params.fetch("id"))
  venue_to_be_deleted= Venue.find(venue_id)
  venue_to_be_deleted.destroy()
  redirect("/admin")
end

get('/category/:id') do
  @category=Category.find(Integer(params.fetch('id')))
  erb(:category)
end

patch("/category/:id") do
  category_id=Integer(params.fetch('id'))
  name = params.fetch("name")
  @category = Category.find(params.fetch("id").to_i())
  @category.update({:name => name})
  redirect("/category/#{category_id}")
end


delete("/category/:id") do
  category_id=Integer(params.fetch("id"))
  category_to_be_deleted= Category.find(category_id)
  category_to_be_deleted.destroy()
  redirect("/admin")
end

get("/user") do
  @categories = Category.all()
  @events= Event.all()
  @venues= Venue.all()
  @artists=Artist.all()
  @offers=Offer.all()
  @color = "%06x" % (rand * 0xffffff)
  erb(:user)
end

get("/search") do
  searchTerm= params.fetch("search").downcase
  @foundEvents = Event.where("name LIKE ?", "%#{searchTerm}%")
  @foundArtists = Artist.where("name = ?", "%#{searchTerm}%")
  @foundOffers = []
  @foundArtists.each do |artist|
    @foundArtistEvents=ArtistsEvent.where("artist_id= ?",artist.id)
    @foundArtistEvents.each do |event|
      @foundOffers=Offer.where("event_id= ?",event.event_id)

    end
  end
  @foundEvents.each do |event|
    @foundOffers = []
    @foundOffers=Offer.where("event_id= ?",event.id)
  end
  erb(:results)
end

#offers many-many table
get('/offer') do
  @offers = Offer.all()
  erb(:offer)
end

get ('/categorysearch') do
  categoryId = params.fetch('categorysearch')
  chosenCategory = Category.find(categoryId)
  @foundOffers = []
  @foundEvents = Event.where("category_id = ?",categoryId)
  @foundEvents.each do |event|
    @foundOffers=Offer.where("event_id= ?",event.id)
  end
  erb(:results)
end

post("/offer") do

    event_id = params.fetch("event_id").to_i()
    price = 'HK$ ' + params.fetch("price")
    user = @user
    bs = params.fetch("offer")

    if bs == "true"
      @offer = Offer.new({:event_id => event_id, :user_id => @user.id(), :price => price, :buy_sell => true})
    else
      @offer = Offer.new({:event_id => event_id, :user_id => @user.id(), :price => price, :buy_sell => false})
    end

    @offer.save()
    @offers = Offer.all()
    redirect("/user")
  end

  get('/offer/:id') do
    @offer=Offer.find(Integer(params.fetch('id')))
    @venue = Venue.all().find(@offer.event.id).address()
    erb(:offer_info)
  end


delete("/offer/:id") do
    @offer = Offer.find(params.fetch("id").to_i())
    @offer.delete()
    redirect ('/user')
end

post("/user_contact") do
  @offer = Offer.find(params.fetch('offer_id').to_i())
  erb(:user_contact)
end

get("/manage_sales") do
  @offers = Offer.all()
  erb(:manage_sales)
end

get('/maps_marker') do
  @venue = Venue.all()
  @arr = Venue.arr()
  erb(:maps_marker)
end
