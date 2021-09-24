require 'rails_helper'

RSpec.describe 'airline#show' do
  before :each do

    @a1 = Airline.create!(name: 'United')
    @a2 = Airline.create!(name: 'Spirit')

    @f1 = @a1.flights.create!(number: 9999, date: '03/11/2021', departure_city: 'Nashville', arrival_city: 'Chicago')
    @f2 = @a2.flights.create!(number: 8888, date: '10/07/2021', departure_city: 'Louisville', arrival_city: 'Denver')
    @f3 = @a2.flights.create!(number: 5555, date: '08/18/2021', departure_city: 'Louisville', arrival_city: 'Puerto Vallarta')

    @p1 = @f3.passengers.create!(name: 'JJ', age: 35)
    @p2 = @f3.passengers.create!(name: 'Jes Mae', age: 34)
    @p3 = @f3.passengers.create!(name: 'Christian', age: 15)

    Excursion.create!(passenger:@p1, flight: @f3)
    Excursion.create!(passenger:@p2, flight: @f3)
    Excursion.create!(passenger:@p3, flight: @f3)

    visit airline_path(@a2)
  end

  it 'can list only adult passengers with zero duplicates' do

   expect(page).to have_content(@p1.name, count:1)
   expect(page).to have_content(@p2.name)
   expect(page).to_not have_content(@p3.name)
 end
end
