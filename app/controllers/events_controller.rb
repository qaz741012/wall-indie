class EventsController < ApplicationController
  before_action :set_event, only: [:follow, :unfollow, :show]
  before_action :authenticate_user!, only: [:follow, :unfollow]

  def index
    #application template flag
    @fix = true
    @features = Event.all
    @events = Event.all.includes(:artists, :places)
    @places = Place.all
    @hash = Gmaps4rails.build_markers(@places) do |place, marker|
      marker.lat place.latitude
      marker.lng place.longitude
      marker.infowindow place.name
    end
  end

  # 顯示所有event的頁面
  def all_events
    @events = Event.all.includes(:artists, :places).order(:date)
  end

  def follow
    event_followship = @event.event_followships.build(user: current_user)
    event_followship.save
    render json: {id: @event.id}
  end

  def unfollow
    event_followship = @event.event_followships.where(user_id: current_user.id)[0]
    event_followship.destroy
    render json: {id: @event.id}
  end

  def show
    @artists = @event.artists
    @place = @event.places[0]
  end

  private

  def event_params
    params.require(:event).permit(:name, :photo, :intro, :date, :time, :orgnization)
  end

  def set_event
    @event = Event.find(params[:id])
  end
end
