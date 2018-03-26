class EventsController < ApplicationController

  def index
    #application template flag
    @fix = true
    @features = Event.all
    @places = Place.all
    @hash = Gmaps4rails.build_markers(@places) do |place, marker|
      marker.lat place.latitude
      marker.lng place.longitude
      marker.infowindow place.info 
  end
  end

  # 顯示所有event的頁面
  def all_events
    @events = Event.all.includes(:artists, :places).order(:date)
  end

  private

  def event_params
    params.require(:event).permit(:name, :photo, :intro, :date, :time, :orgnization)

  end
end
