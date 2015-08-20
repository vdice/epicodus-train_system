require('capybara/rspec')
require('./app')
Capybara.app = Sinatra::Application
set(:show_exceptions, false)
require('spec_helper')

describe('The Train System App', {:type => :feature}) do
  describe('The operator app') do
    describe('the operator home page path') do
      it('allows operators to to visit their home page') do
        visit('/')
        click_link('Operator')
        expect(page).to have_content('Manage All Trains')
      end
    end

    describe('the operator trains path') do
      it('allows the operator to manage trains') do
        train = Train.new({:name => 'yellow', :id => nil})
        train.save()
        visit('/operator')
        click_link('Manage All Trains')
        expect(page).to have_content('yellow')
      end
      it('tells the operator there aren\'t any trains yet') do
        visit('/operator')
        click_link('Manage All Trains')
        expect(page).to have_content('There aren\'t any trains yet.')
      end

      it('allows the operator to add a train') do
        visit('/operator/trains')
        fill_in('name', :with => 'yellow')
        click_button('Add Train')
        expect(page).to have_content('yellow')
      end

      it('allows the operator to delete a train') do
        train = Train.new({:name => 'yellow', :id => nil})
        train.save()
        visit('/operator/trains')
        find('#train_select').find(:xpath, 'option[1]').select_option
        click_button('Delete Train')
        expect(page).to have_content('There aren\'t any trains yet.')
        expect(page).to_not have_content('Delete a Train')
      end

      it('allows the operator to view a specific train') do
        train = Train.new({:name => 'yellow', :id => nil})
        train.save()
        visit('/operator/trains')
        click_link(train.name())
        expect(page).to have_content(train.name())
      end
    end

    describe('the operator unique train path') do
      it('allows the operator to add a city to a train') do
        train = Train.new({:name => 'yellow', :id => nil})
        train.save()
        city = City.new({:name => 'Eugene', :id => nil})
        city.save()
        visit("/trains/#{train.id()}")
        fill_in('name', :with => 'blue')
        find('#city_select').find(:xpath, 'option[1]').select_option
        fill_in('eta', :with => Time.new(2015))
        click_button('Update')
        expect(page).to have_content('Eugene')
      end
      it('allows the operator to return to all trains page') do
        train = Train.new({:name => 'yellow', :id => nil})
        train.save()
        visit("/trains/#{train.id()}")
        click_link('Back')
        expect(page).to have_content('All Trains')
      end
    end

    describe('the operator cities path') do
      it('allows the operator to manage cities') do
        city = City.new({:name => 'Denver', :id => nil})
        city.save()
        visit('/operator')
        click_link('Manage All Cities')
        expect(page).to have_content('Denver')
      end
      it('tells the operator there aren\'t any cities yet') do
        visit('/operator')
        click_link('Manage All Cities')
        expect(page).to have_content('There aren\'t any cities yet.')
      end

      it('allows the operator to add a city') do
        visit('/operator/cities')
        fill_in('name', :with => 'Denver')
        click_button('Add City')
        expect(page).to have_content('Denver')
      end

      it('allows the operator to delete a city') do
        city = City.new({:name => 'Portland', :id => nil})
        city.save()
        visit('/operator/cities')
        find('#city_select').find(:xpath, 'option[1]').select_option
        click_button('Delete City')
        expect(page).to have_content('There aren\'t any cities yet.')
        expect(page).to_not have_content('Delete a City')
      end
    end
  end

  describe('the unique cities path') do
    it('allows the operator to view a specific city') do
      city = City.new({:name => 'Seattle', :id => nil})
      city.save()
      visit('/operator/cities')
      click_link(city.name())
      expect(page).to have_content(city.name())
    end
    it('allows the operator to update a city name') do
      city = City.new({:name => 'Seattle', :id => nil})
      city.save()
      visit("/cities/#{city.id()}")
      fill_in('name', :with => 'San Jose')
      click_button('Update')
      expect(page).to have_content('San Jose')
    end
    it('allows the operator to return to all cities page') do
      city = City.new({:name => 'Eugene', :id => nil})
      city.save()
      visit("/cities/#{city.id()}")
      click_link('Back')
      expect(page).to have_content('All Cities')
    end
  end

  describe('The passenger app') do
    describe('the passenger home page path') do
      it('allows passengers to to visit their home page') do
        train = Train.new({:name => 'yellow', :id => nil})
        train.save()
        city = City.new({:name => 'Eugene', :id => nil})
        city.save()
        train.update({:city_ids => [city.id()]})
        stop = Stop.new({:train => train, :city => city, :eta => Time.new()})
        stop.save()
        visit('/')
        click_link('Passenger')
        expect(page).to have_selector('#trains_listing li[1]', text: "#{train.name()}, #{city.name()}, #{stop.eta().strftime("%I:%M %p")}")
        expect(page).to have_selector('#cities_listing li[1]', text: "#{city.name()}, #{train.name()}, #{stop.eta().strftime("%I:%M %p")}")
      end
      it('allows passenger to purchase a ticket') do
# todo
      end
    end
  end
end
