require 'rails_helper'

RSpec.describe "Flight Show Page" do
  before(:each) do
    @flight1 = Flight.create(number: 626, date: "03/05/21", time: "0916", departure_city: "SFO", arrival_city: "LAX")
    
    @passenger1 = @flight1.passengers.create(name: "Larry", age: 28)
    @passenger2 = @flight1.passengers.create(name: "Curly", age: 31)
    @passenger3 = @flight1.passengers.create(name: "Moe", age: 30)

    @passenger4 = @flight1.passengers.create(name: "Shirley Temple", age: 8)
    @passenger5 = @flight1.passengers.create(name: "Macaulay Culkin", age: 9)
  end

  describe "As a visitor" do
    it "shows the flight's number, date, time, departure city, and arrival city" do
      visit flight_path(@flight1)
      
      expect(page).to have_content(@flight1.number)
      expect(page).to have_content(@flight1.date)
      expect(page).to have_content(@flight1.time)
      expect(page).to have_content(@flight1.departure_city)
      expect(page).to have_content(@flight1.arrival_city)
    end
    
    it "shows the names of all adult passengers only that are on the flight" do
      visit flight_path(@flight1)
      
      within("#passenger-#{@passenger1.id}") do
        expect(page).to have_content(@passenger1.name)
      end
      
      within("#passenger-#{@passenger2.id}") do
        expect(page).to have_content(@passenger2.name)
      end
      
      within("#passenger-#{@passenger3.id}") do
        expect(page).to have_content(@passenger3.name)
      end

      within("#passenger-info") do
        expect(page).to_not have_content(@passenger4.name)
        expect(page).to_not have_content(@passenger5.name)
      end
    end
    
    it "shows the average age of all adult passengers on the flight" do
      visit flight_path(@flight1)
      
      expect(page).to have_content("Average Adult Passenger age: #{@flight1.average_adult_passenger_age.round(2)}")
    end
    
    it "has a button next to the passengers name to remove them from the flight" do
      visit flight_path(@flight1)
      
      within("#passenger-#{@passenger1.id}") do
        expect(page).to have_button("Remove Passenger")
      end
      
      within("#passenger-#{@passenger2.id}") do
        expect(page).to have_button("Remove Passenger")
      end
      
      within("#passenger-#{@passenger3.id}") do
        expect(page).to have_button("Remove Passenger")
      end      
    end
    
    describe "When I click on that link or button" do
      it "takes me back to the flight show page and no longer shows the passenger" do
        visit flight_path(@flight1)
        
        within("#passenger-#{@passenger1.id}") do
          click_button("Remove Passenger")
          expect(current_path).to eq(flight_path(@flight1))
        end
        
        within("#passenger-info") do
          expect(page).to_not have_content(@passenger1.name)
        end
      end
    end
  end
  
end