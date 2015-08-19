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
        train = Train.new({:name => 'yellow', :eta => Time.new(2015), :id => nil})
        train.save()
        visit('/operator')
        click_link('Manage All Trains')
        expect(page).to have_content(Time.new(2015))
      end
      it('tells the operator there aren\'t any trains yet') do
        visit('/operator')
        click_link('Manage All Trains')
        expect(page).to have_content('There aren\'t any trains yet.')
      end

      it('allows the operator to add a train') do
        visit('/operator/trains')
        fill_in('new_train', :with => 'yellow')
        click_button('Add Train')
        expect(page).to have_content()
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
    end
  end

  describe('The passenger app') do
    describe('the passenger home page path') do
      it('allows passengers to to visit their home page') do
        visit('/')
        click_link('Passenger')
        expect(page).to have_content('View All Trains')
      end
    end
  end
end
