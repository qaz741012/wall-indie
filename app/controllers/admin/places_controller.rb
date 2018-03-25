class Admin::PlacesController < ApplicationController
  def index
    @places = Place.all
  end

  def new
    @place = Place.new
  end
end
