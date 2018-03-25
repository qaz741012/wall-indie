class Admin::PlacesController < ApplicationController
  def index
    @places = Place.all
  end

end
