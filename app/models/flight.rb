class Flight < ApplicationRecord

  has_many :manifests
  has_many :passengers, through: :manifests

  def self.flights_alphabetically
    order(departure_city: :asc)
  end

  def self.passenger_count_order
    joins(:passengers)
    .select('flights.*, count(passengers.id) as passenger_count')
    .group('flights.id')
    .order("passenger_count DESC, departure_city ASC")
  end

  def adult_passengers
    passengers.where('age >= ?', 18)
  end

  def average_adult_passenger_age
    adult_passengers.average(:age)
  end
end
