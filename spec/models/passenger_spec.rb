require 'rails_helper'

RSpec.describe Passenger, type: :model do
  describe "Relationships" do
    it { should have_many :manifests }
    it { should have_many(:flights).through(:manifests) }
  end
end
