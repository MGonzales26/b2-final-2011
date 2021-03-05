require 'rails_helper'

RSpec.describe Flight, type: :model do
  it { should have_many :manifests }
  it { should have_many(:passengers).through(:manifests) }
end
