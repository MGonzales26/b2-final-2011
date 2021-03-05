require 'rails_helper'

RSpec.describe Manifest, type: :model do
  describe "Relationships" do
    it { should belong_to :flight }
    it { should belong_to :passenger }
  end
end
