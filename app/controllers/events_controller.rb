class EventsController < ApplicationController
  def new
    @event = Event.new
  end

  def create
    byebug

    @event = Event.new(event_create_params)

    if params[:search_address].present?
      zipcode = Zipcode.find_by(id: event_create_params[:zipcode])
      prefecture = zipcode.prefecture
      city = prefecture.city
      town = city.town
      @event.zipcode_address = "#{prefecture.name}#{city.name}#{town.name}"
        
       return render :new
    end



    if @event.save
      redirect_to @event
    else
      render :new
    end
  end

  def show
    @event = Event.find(params[:id])
    @comment = EventComment.new
  end

  def edit
    @event = Event.find(params[:id])
  end

  def update
    @event = Event.find(params[:id])
    # status = params[:publish_button].present? ? 'active' : 'inactive'

    ActiveRecord::Base.transaction do
      if @event.update(event_create_params)
        redirect_to @event
      else
        render :new
      end
    end
  end

  private

  def event_create_params
    params.require(:event).permit(:name, :price, :people_limit, :description, :held_at, :deadline_at).merge(master: current_user)
  end
end
