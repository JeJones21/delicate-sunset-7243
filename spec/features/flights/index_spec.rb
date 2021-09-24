require 'rails_helper'

RSpec.describe 'Flight#index' do
  before :each do

    @a1 = Airline.create!(name: 'United')
    @a2 = Airline.create!(name: 'Spirit')

    @f1 = @a1.flights.create!(number: 5555, date: '08/18/2021', departure_city: 'Louisville', arrival_city: 'Puerto Vallarta')
    @f2 = @a1.flights.create!(number: 8888, date: '10/07/2021', departure_city: 'Louisville', arrival_city: 'Denver')
    @f3 = @a2.flights.create!(number: 0123, date: '03/11/2021', departure_city: 'Nashville', arrival_city: 'Chicago')

    @p1 = @f1.passengers.create!(name: 'JJ', age: 35)
    @p2 = @f1.passengers.create!(name: 'Jes Mae', age: 34)
    @p3 = @f1.passengers.create!(name: 'Christian', age: 39)

    visit flights_path
  end

  it "can list all flight numbers" do
    save_and_open_page

    expect(page).to have_content(@f1.number)
    expect(page).to have_content(@f2.number)
    expect(page).to have_content(@f3.number)
  end
end
