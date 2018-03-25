class Admin::PlacesController < ApplicationController
  def index
    @places = Place.all
  end

  def new
    @place = Place.new
  end

  def create
    @place = Place.new(place_params)
    if @place.save
      flash[:notice] = "place was successfully create"
      redirect_to admin_places_path
    else
      flash[:alert] = "place was failed to create"
      render :new
    end

  end

  private

  def place_params
    params.require(:place).permit(:name, :address, :tel, :info, :latitude, :longitude)
  end
end
