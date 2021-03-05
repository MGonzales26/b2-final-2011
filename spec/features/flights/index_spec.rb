require 'rails_helper'

RSpec.describe "Flight Index Page" do
  before(:each) do
    @flight1 = Flight.create(number: 626, date: "03/05/21", time: "0916", departure_city: "SFO", arrival_city: "NO")
    @flight2 = Flight.create(number: 118, date: "03/05/21", time: "1403", departure_city: "LAX", arrival_city: "YES")
    @flight3 = Flight.create(number: 128, date: "03/05/21", time: "0800", departure_city: "DIA", arrival_city: "FLA")
    @flight4 = Flight.create(number: 1128, date: "03/05/21", time: "1500", departure_city: "DFW", arrival_city: "NYC")

    @passenger7 = @flight1.passengers.create(name: "Elon Musk", age: 49)
    @passenger1 = @flight2.passengers.create(name: "Larry", age: 28)
    @passenger4 = @flight3.passengers.create(name: "Shirley Temple", age: 8)
    @passenger8 = @flight4.passengers.create(name: "john smith", age: 18)
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
    
    it "lists flights by number passengers from most to least" do
      flight1 = Flight.create(number: 626, date: "03/05/21", time: "0916", departure_city: "SFO", arrival_city: "NO")
      flight2 = Flight.create(number: 18, date: "03/05/21", time: "1403", departure_city: "LAX", arrival_city: "YES")
      flight3 = Flight.create(number: 10128, date: "03/05/21", time: "0800", departure_city: "DIA", arrival_city: "FLA")
      flight4 = Flight.create(number: 1128, date: "03/05/21", time: "1500", departure_city: "DFW", arrival_city: "NYC")

      passenger7 = flight1.passengers.create(name: "Elon Musk", age: 49)

      passenger1 = flight2.passengers.create(name: "Larry", age: 28)
      passenger2 = flight2.passengers.create(name: "Curly", age: 31)
      passenger3 = flight2.passengers.create(name: "Moe", age: 30)

      passenger4 = flight3.passengers.create(name: "Shirley Temple", age: 8)
      passenger5 = flight3.passengers.create(name: "Macaulay Culkin", age: 9)

      passenger8 = flight4.passengers.create(name: "john smith", age: 18)
      passenger9 = flight4.passengers.create(name: "jane smith", age: 20)
      passenger10 = flight4.passengers.create(name: "bobby", age: 11)
      passenger11 = flight4.passengers.create(name: "lizzy", age: 35)

      visit flights_path

      expect(page).to have_content(flight4.number)
      expect(page).to have_content(flight2.number)
      expect(page).to have_content(flight3.number)
      expect(page).to have_content(flight1.number)

      expect(flight4.departure_city).to appear_before(flight2.departure_city)
      expect(flight2.departure_city).to appear_before(flight3.departure_city)
      expect(flight3.departure_city).to appear_before(flight1.departure_city)
    end

  end
end