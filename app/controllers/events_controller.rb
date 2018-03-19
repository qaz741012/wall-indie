class EventsController < ApplicationController

  def index
    #application template flag
    @fix = true
    @features = Event.all
  end

  private

  def event_params
    params.require(:event).permit(:name, :photo, :intro, :date, :time, :orgnization)
    
  end
end
