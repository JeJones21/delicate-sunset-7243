require 'rails_helper'

RSpec.describe 'Flight#index' do
  before :each do

    @a1 = Airline.create!(name: 'United')
    @a2 = Airline.create!(name: 'Spirit')

    @f1 = @a1.flights.create!(number: 9999, date: '03/11/2021', departure_city: 'Nashville', arrival_city: 'Chicago')
    @f2 = @a2.flights.create!(number: 8888, date: '10/07/2021', departure_city: 'Louisville', arrival_city: 'Denver')
    @f3 = @a2.flights.create!(number: 5555, date: '08/18/2021', departure_city: 'Louisville', arrival_city: 'Puerto Vallarta')

    @p1 = @f3.passengers.create!(name: 'JJ', age: 35)
    @p2 = @f3.passengers.create!(name: 'Jes Mae', age: 34)
    @p3 = @f3.passengers.create!(name: 'Christian', age: 39)

    visit flights_path
  end

  it "can list all flight numbers" do
    save_and_open_page

    expect(page).to have_content(@f1.number)
    expect(page).to have_content(@f2.number)
    expect(page).to have_content(@f3.number)
  end

  it "can list flight and passenger info" do
    within("#flight-numbers-#{@f1.id}") do
      expect(page).to have_content(@f1.number)
      expect(page).to have_content(@a1.name)

      expect(page).to_not have_content(@f2.number)
      expect(page).to_not have_content(@p2.name)
      expect(page).to_not have_content(@a2.name)
    end

    within("#flight-numbers-#{@f2.id}") do
       expect(page).to have_content(@a2.name)
       expect(page).to have_content(@f2.number)

       expect(page).to_not have_content(@f1.number)
       expect(page).to_not have_content(@a1.name)
       expect(page).to_not have_content(@p1.name)
     end

     within("#flight-numbers-#{@f3.id}") do
       expect(page).to have_content(@f3.number)
       expect(page).to have_content(@a2.name)
       expect(page).to have_content(@p1.name)
       expect(page).to have_content(@p2.name)
       expect(page).to have_content(@p3.name)

       expect(page).to_not have_content(@f2.number)
       expect(page).to_not have_content(@a1.name)
     end
  end

  it "has a link or button to remove a passenger from a flight bc they got drunk and refused to wear a mask and then was duct taped to a seat" do
    within("#flight-numbers-#{@f3.id}") do
        expect(page).to have_link("Remove #{@p3.name}")

        click_link "Remove #{@p3.name}"

        expect(current_path).to eq(flights_path)

        expect(page).to_not have_content(@p3.name)
      end


  end
end
