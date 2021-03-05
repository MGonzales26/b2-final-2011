require 'rails_helper'

RSpec.describe Flight, type: :model do
  describe "Relationships" do
    it { should have_many :manifests }
    it { should have_many(:passengers).through(:manifests) }
  end

  describe "Class Methods" do
    describe "::flights_alphabetically" do
      it "lists all of the flights in alphabetical order" do
        flight1 = Flight.create(number: 626, date: "03/05/21", time: "0916", departure_city: "SFO", arrival_city: "LAX")
        flight2 = Flight.create(number: 1128, date: "03/05/21", time: "1403", departure_city: "LAX", arrival_city: "DIA")
        flight3 = Flight.create(number: 1128, date: "03/05/21", time: "0800", departure_city: "DIA", arrival_city: "DFW")
        flight4 = Flight.create(number: 1128, date: "03/05/21", time: "1500", departure_city: "DFW", arrival_city: "DIA")

        expected = [flight4, flight3, flight2, flight1]

        expect(Flight.flights_alphabetically).to eq(expected)
      end
    end

    describe "::passenger_count_order" do
      it "lists all of the flights in order by most passengers to least" do
        flight1 = Flight.create(number: 626, date: "03/05/21", time: "0916", departure_city: "SFO", arrival_city: "LAX")
        flight2 = Flight.create(number: 1128, date: "03/05/21", time: "1403", departure_city: "LAX", arrival_city: "DIA")
        flight3 = Flight.create(number: 1128, date: "03/05/21", time: "0800", departure_city: "DIA", arrival_city: "DFW")
        flight4 = Flight.create(number: 1128, date: "03/05/21", time: "1500", departure_city: "DFW", arrival_city: "DIA")
        flight5 = Flight.create(number: 1128, date: "03/05/21", time: "0800", departure_city: "MDW", arrival_city: "DFW")

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

        passenger12 = flight5.passengers.create(name: "lizzy", age: 35)
        passenger13 = flight5.passengers.create(name: "susie", age: 6)


        expected = [flight4, flight2, flight3, flight5, flight1]

        expect(Flight.passenger_count_order).to eq(expected)
      end
    end
  end

  describe "Instance Methods" do
    describe "#adult_passengers" do
      it "lists all of the adult passengers, 18 or over, on a flight" do
        flight1 = Flight.create(number: 626, date: "03/05/21", time: "0916", departure_city: "SFO", arrival_city: "LAX")
    
        passenger1 = flight1.passengers.create(name: "Larry", age: 28)
        passenger2 = flight1.passengers.create(name: "Curly", age: 31)
        passenger3 = flight1.passengers.create(name: "Moe", age: 30)
    
        passenger4 = flight1.passengers.create(name: "Shirley Temple", age: 8)
        passenger5 = flight1.passengers.create(name: "Macaulay Culkin", age: 9)

        expected = [passenger1, passenger2, passenger3]
        
        expect(flight1.adult_passengers).to eq(expected)
      end
    end

    describe "#average_adult_passenger_age" do
      it "returns the average age of all passengers 18 or older" do
        flight1 = Flight.create(number: 626, date: "03/05/21", time: "0916", departure_city: "SFO", arrival_city: "LAX")
    
        passenger1 = flight1.passengers.create(name: "Larry", age: 29)
        passenger2 = flight1.passengers.create(name: "Curly", age: 31)
        passenger3 = flight1.passengers.create(name: "Moe", age: 30)
    
        passenger4 = flight1.passengers.create(name: "Shirley Temple", age: 8)
        passenger5 = flight1.passengers.create(name: "Macaulay Culkin", age: 9)

        
        expect(flight1.average_adult_passenger_age).to eq(30)
      end
    end
  end
end
