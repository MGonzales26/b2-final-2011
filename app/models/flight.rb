class Flight < ApplicationRecord

  has_many :manifests
  has_many :passengers, through: :manifests

  def self.flights_alphabetically
    order(departure_city: :asc)
  end
end
