class Flight < ApplicationRecord

  has_many :manifests
  has_many :passengers, through: :manifests
end
