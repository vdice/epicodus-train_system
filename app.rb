require('sinatra')
require('sinatra/reloader')
also_reload('lib/**/*.rb')
require('./lib/city')
require('./lib/train')
require('./lib/stop')
require('pg')
require('pry')

DB = PG.connect({:dbname => "train_system_test"})

get('/') do
  erb(:index)
end

get('/operator') do
  erb(:operator)
end

get('/passenger') do
  @stops = Stop.all()
  @trains = Train.all()
  @cities = City.all()
  erb(:passenger)
end

get('/operator/trains') do
  @trains = Train.all()
  erb(:trains)
end

get('/operator/cities') do
  @cities = City.all()
  erb(:cities)
end

post('/operator/trains') do
  name = params.fetch('name')
  new_train = Train.new({:name => name, :id => nil})
  new_train.save()
  @trains = Train.all()
  erb(:trains)
end

post('/operator/cities') do
  name = params.fetch('name')
  new_city = City.new({:name => name, :id => nil})
  new_city.save()
  @cities = City.all()
  erb(:cities)
end

delete('/operator/trains') do
  train = Train.find(params.fetch('train_select').to_i)
  train.delete()
  @trains = Train.all()
  erb(:trains)
end

delete('/operator/cities') do
  city = City.find(params.fetch('city_select').to_i)
  city.delete()
  @cities = City.all()
  erb(:cities)
end

get('/trains/:id') do
  @train = Train.find(params.fetch('id').to_i)
  @cities = City.all()
  @stops = Stop.all()
  erb(:train)
end

get('/cities/:id') do
  @city = City.find(params.fetch('id').to_i)
  erb(:city)
end

patch('/trains/:id') do
  @cities = City.all()
  @train = Train.find(params.fetch('id').to_i)

  name = params.fetch('name').empty?() ? @train.name() : params.fetch('name')

  if !params.fetch('city_select').empty? && !params.fetch('eta').empty?
    eta = Time.parse(params.fetch('eta'))
    city_id = params.fetch('city_select').to_i
    city = City.find(city_id)

    new_stop = Stop.new({:train => @train, :city => city, :eta => eta, :id => nil})

    @train.update({:name => name, :city_id => city_id, :eta => eta})
  else
    @train.update({:name => name})
  end

  @stops = Stop.all()
  erb(:train)
end

patch('/cities/:id') do
  @city = City.find(params.fetch('id').to_i)
  name = params.fetch('name')
  @city.update({:name => name})
  erb(:city)
end

get('/stops/:id') do
  @stop = 
  erb(:purchase)
end
