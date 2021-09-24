require 'rails_helper'

RSpec.describe Passenger, type: :model do
  describe 'relationships' do
    it { should have_many(:excursions) }
    it { should have_many(:flights).through(:excursions) }
  end
end
