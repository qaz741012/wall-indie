class EventsController < ApplicationController
  before_action :set_event, only: [:follow, :unfollow, :show]
  before_action :authenticate_user!, only: [:follow, :unfollow]

  def index
    #application template flag
    @fix = true
    @features = Event.all
    @events = Event.includes(:artists, :places).where('date >= ?', Date.today)
    .order(date: :asc).limit(9)
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

  # ========mail test=========
  #If there is something new in event data,
  #the create method will be triggered.
  def create
    @event = Event.new(params[:id])
    respond_to do |format|
      if @event.save
        #trigger
        # notice_user_new_event(@event)
        format.html {
          redirect_to(@Event, notice: 'Event was successfully created.') }
        format.json {
          render json: @event, status: :created, location: @event }
      else
        format.html { render action: 'new' }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
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

  # ========mail test=========
  # send to [a,b,c],[e,f],[a,f,h,j]fans
  # of following A,B,C artists

  def notice_user_new_event(event)
    @artists = event.artists
    @artists.each do |artist|
      @users = artist.artist_followed
      @users.each do |user|
        UserMailer.artist_new_evnet(@users).deliver_later
      end
    end
  end
end
