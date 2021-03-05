class ManifestsController < ApplicationController

  def destroy
    @flight = Flight.find(params[:flight_id])
    manifest = Manifest.where(flight_id: @flight.id, passenger_id: params[:passenger_id]).first
    Manifest.destroy(manifest.id)
    redirect_to flight_path(@flight)
  end
end