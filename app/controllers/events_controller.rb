class EventsController < ApplicationController
  before_action :set_event, only: [:follow, :unfollow, :show]
  before_action :authenticate_user!, only: [:follow, :unfollow]

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
    @events = Event.all.includes(:artists, :places)
  end

  # 顯示所有event的頁面
  def all_events
    @events = Event.all.includes(:artists, :places).order(:date)
  end

  def follow
    event_followship = @event.event_followships.build(user: current_user)
    if event_followship.save
      flash[:notice] = "Successfully followed!"
    else
      flash[:alert] = event_followship.errors.full_messages.to_sentence
    end
    redirect_back(fallback_location: root_path)
  end

  def unfollow
    event_followship = @event.event_followships.where(user_id: current_user.id)[0]
    if event_followship
      event_followship.destroy
      flash[:notice] = "Successfully unfollowed!"
    else
      flash[:alert] = "You haven't followed the event yet"
    end
    redirect_back(fallback_location: root_path)
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
