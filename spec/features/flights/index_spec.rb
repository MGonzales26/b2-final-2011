require 'rails_helper'

RSpec.describe "Flight Index Page" do
  before(:each) do
    @flight1 = Flight.create(number: 626, date: "03/05/21", time: "0916", departure_city: "SFO", arrival_city: "LAX")
    @flight2 = Flight.create(number: 1128, date: "03/05/21", time: "1403", departure_city: "LAX", arrival_city: "DIA")
    @flight3 = Flight.create(number: 1128, date: "03/05/21", time: "0800", departure_city: "DIA", arrival_city: "DFW")
    @flight4 = Flight.create(number: 1128, date: "03/05/21", time: "1500", departure_city: "DFW", arrival_city: "DIA")

  end
  describe "As a visitor" do
    it "shows each flight in the system including its number, departure city, and arrival city" do
      visit flights_path
      
      within("#flight-#{@flight1.id}") do
        expect(page).to have_content(@flight1.number)
        expect(page).to have_content(@flight1.departure_city)
        expect(page).to have_content(@flight1.arrival_city)
      end
      
      within("#flight-#{@flight2.id}") do
        expect(page).to have_content(@flight2.number)
        expect(page).to have_content(@flight2.departure_city)
        expect(page).to have_content(@flight2.arrival_city)
      end
      
      within("#flight-#{@flight3.id}") do
        expect(page).to have_content(@flight3.number)
        expect(page).to have_content(@flight3.departure_city)
        expect(page).to have_content(@flight3.arrival_city)
      end
      
      within("#flight-#{@flight4.id}") do
        expect(page).to have_content(@flight4.number)
        expect(page).to have_content(@flight4.departure_city)
        expect(page).to have_content(@flight4.arrival_city)
      end
    end
    
    it "lists flights in alphabetical order by departure city (A - Z)" do
      visit flights_path

      expect(@flight4.departure_city).to appear_before(@flight3.departure_city)
      expect(@flight3.departure_city).to appear_before(@flight2.departure_city)
      expect(@flight2.departure_city).to appear_before(@flight1.departure_city)
    end
  end
end

