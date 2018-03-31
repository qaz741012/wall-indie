# manage Events for admin
class Admin::EventsController < Admin::BaseController
  def index
    @events = Event.all
  end

  def edit
    @event = Event.find(params[:id])
  end

  def update
    @event = Event.find(params[:id])
    if @event.update(event_params)
      flash[:notice] = 'event was successfully update'
      redirect_to admin_events_path
    else
      flash[:alert] = 'event was failed to create'
      render :edit
    end
  end

  private

  def event_params
    params.require(:event).permit(:name, :date, :time, :address)
  end
end
