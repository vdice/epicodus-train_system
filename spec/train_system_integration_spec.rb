require('capybara/rspec')
require('./app')
Capybara.app = Sinatra::Application
set(:show_exceptions, false)
require('spec_helper')

describe('The Train System App', {:type => :feature}) do

  describe('the operator home page path') do
    it('allows operators to to visit their home page') do
      visit('/')
      click_link('Operator')
      expect(page).to have_content('Manage All Trains')
    end
  end

  describe('the passenger home page path') do
    it('allows passengers to to visit their home page') do
      visit('/')
      click_link('Passenger')
      expect(page).to have_content('View All Trains')
    end
  end
end
