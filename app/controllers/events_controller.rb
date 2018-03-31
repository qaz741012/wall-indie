# Events controller so gooood
class EventsController < ApplicationController
  before_action :set_event, only: %i[follow unfollow show]
  before_action :authenticate_user!, only: %i[follow unfollow]

  def index
    # application template flag
    @fix = true
    @feature_events = Event.feature
    sorting_event(params[:q])
    @places = Place.all
    build_markers(@places)
  end

  # show all the events
  def all_events
    @events = Event.where('date >= ?', Date.today).order(date: :asc)
  end

  def follow
    event_followship = @event.event_followships.build(user: current_user)
    event_followship.save
    render json: { id: @event.id }
  end

  def unfollow
    event_followship = @event.where(user_id: current_user.id)[0]
    event_followship.destroy
    render json: { id: @event.id }
  end

  # ========mail test=========
  # If there is something new in event data,
  # the create method will be triggered.
  def create
    @event = Event.new(params[:id])
    respond_to do |format|
      if @event.save
        # trigger
        # notice_user_new_event(@event)
        format.html { redirect_to(@Event, notice: 'Event was created.') }
        format.json { render json: @event, status: :created, location: @event }
      else
        format.html { render action: 'new' }
        format.json render json: @event.errors, status: :unprocessable_entity
      end
    end
  end

  def show
    @artists = @event.artists
    @event_followed = @event.event_followed
    @place = @event.places[0]
  end

  private

  def event_params
    params.permit(:name, :photo, :intro, :date, :time, :orgnization)
  end

  def set_event
    @event = Event.find(params[:id])
  end

  # ========mail test=========
  # send to [a,b,c],[e,f],[a,f,h,j]fans
  # of following A,B,C artists
  def notice_user_new_event(event)
    @artists = event.artists
    @artists.each do |artist|
      @users = artist.artist_followed
      @users.each do
        UserMailer.artist_new_evnet(@users).deliver_later
      end
    end
  end

  def build_markers(places)
    @hash = Gmaps4rails.build_markers(places) do |place, marker|
      marker.lat place.latitude
      marker.lng place.longitude
      marker.infowindow place.name
    end
  end

  def sorting_event(params)
    @events_search = Event.ransack(params)
    @events = @events_search.result(distinct: true).order(:date)

    return unless params.nil? || params.values[0].blank?
    @events = Event.where('date >= ?', Date.today).order(date: :asc).limit(8)
  end
end
