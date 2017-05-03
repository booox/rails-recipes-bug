class Admin::EventsController < AdminController
  before_action :find_event, only: [:show, :edit, :update, :destroy]

  def index
    @events = Event.all
  end

  def show
  end

  def new
    @event = Event.new
    @event.tickets.build
  end

  def create
    @event = Event.new(event_params)

    if @event.save
      redirect_to admin_events_path
    else
      render :new
    end
  end

  def edit
    @event.tickets.build if @event.tickets.empty?
  end

  def update

    if @event.update(event_params)
      redirect_to admin_events_path
    else
      render :edit
    end
  end

  def destroy
    @event.destroy

    redirect_to admin_events_path
  end

  private

    def find_event
      @event = Event.find_by_friendly_id!(params[:id])
    end


  protected

  def event_params
    params.require(:event).permit(:name, :description, :friendly_id, :status,
                    :category_id, tickets_attributes: [:id, :name,
                      :description, :price, :_destroy])
  end

end
