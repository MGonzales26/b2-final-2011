require 'rails_helper'

RSpec.describe Flight, type: :model do
  describe "Relationships" do
    it { should have_many :manifests }
    it { should have_many(:passengers).through(:manifests) }
  end

  describe "Class Methods" do
    describe "::flights_alphabetically" do
      it "lists all of the flights in alphabetical order" do
        @flight1 = Flight.create(number: 626, date: "03/05/21", time: "0916", departure_city: "SFO", arrival_city: "LAX")
        @flight2 = Flight.create(number: 1128, date: "03/05/21", time: "1403", departure_city: "LAX", arrival_city: "DIA")
        @flight3 = Flight.create(number: 1128, date: "03/05/21", time: "0800", departure_city: "DIA", arrival_city: "DFW")
        @flight4 = Flight.create(number: 1128, date: "03/05/21", time: "1500", departure_city: "DFW", arrival_city: "DIA")

        expected = [@flight4, @flight3, @flight2, @flight1]

        expect(Flight.flights_alphabetically).to eq(expected)
      end
    end
  end
end
