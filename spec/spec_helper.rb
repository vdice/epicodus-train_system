require('rspec')
require('city')
require('train')
require('stop')
require('time')
require('pg')

DB = PG.connect({:dbname => "train_system_test"})

RSpec.configure do |config|
  config.before(:each) do
    DB.exec("DELETE FROM cities *;")
    DB.exec("DELETE FROM trains *;")
    DB.exec("DELETE FROM stops *;")
  end
end
