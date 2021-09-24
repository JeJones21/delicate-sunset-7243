class ExcursionsController < ApplicationController

  def destroy
    flight = Flight.find(params[:flight_id])
    passenger = Passenger.find(params[:id])
    excursion = Excursion.find_by(flight: flight, passenger: passenger)
    excursion.destroy

    redirect_to flights_path
  end
end
