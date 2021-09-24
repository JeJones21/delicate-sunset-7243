require 'rails_helper'

RSpec.describe Flight do
  describe 'relationships' do
    it { should belong_to(:airline) }
    it { should have_many(:excursions) }
    it { should have_many(:passengers).through(:excursions) }
  end
end
