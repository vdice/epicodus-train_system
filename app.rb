require('sinatra')
require('sinatra/reloader')
also_reload('lib/**/*.rb')
require('./lib/city')
require('./lib/train')
require('pg')

DB = PG.connect({:dbname => "train_system_test"})

get('/') do
  erb(:index)
end

get('/operator') do
  erb(:operator)
end

get('/passenger') do
  erb(:passenger)
end

get('/operator/trains') do
  @trains = Train.all()
  erb(:trains)
end

post('/operator/trains') do
  name = params.fetch('name')
  eta = Time.parse(params.fetch('eta'))
  new_train = Train.new({:name => name, :eta => eta, :id => nil})
  new_train.save()
  @trains = Train.all()
  erb(:trains)
end

get('/operator/cities') do
  @cities = City.all()
  erb(:cities)
end
