class EventsController < ApplicationController
  def index
    @events = Event.open
  end

  def new
    @event = Event.new
    @editable = true
  end

  def create
    @event = Event.new(event_create_params)
    @editable = true

    if params[:search_address].present?
      zipcode = Zipcode.find_by(id: event_create_params[:zipcode_id])
      @event.errors.add(:zipcode_id, '郵便番号を再検索してください') if zipcode.nil?

      town = zipcode&.town
      city = town&.city
      prefecture = city&.prefecture
      @event.zipcode_address = "#{prefecture&.name}#{city&.name}#{town&.name}"
      @event.zipcode = zipcode
      return render :new
    end

    @event.address = @event.zipcode_address + @event.other_address if @event.zipcode_address.present? && @event.other_address.present?

    if @event.save
      redirect_to @event
    else
      render :new
    end
  end

  def show
    @event = Event.find(params[:id])
    @attendance = @event.event_attendances.find_by(user: current_user)
    # @comment = EventComment.new
  end

  def edit
    @event = Event.find(params[:id])
    @event.zipcode_address = "#{@event.zipcode.town.city.prefecture.name}#{@event.zipcode.town.city.name}#{@event.zipcode.town.name}"
    @event.other_address = @event.address.sub(@event.zipcode_address, '')
    @editable = false
  end

  def update
    @event = Event.find(params[:id])

    if params[:search_address].present?
      zipcode = Zipcode.find_by(id: event_create_params[:zipcode_id])
      @event.errors.add(:zipcode_id, '郵便番号を再検索してください') if zipcode.nil?

      town = zipcode&.town
      city = town&.city
      prefecture = city&.prefecture
      @event.zipcode_address = "#{prefecture&.name}#{city&.name}#{town&.name}"
      @event.zipcode = zipcode
      return render :edit
    end

    @event.address = @event.zipcode_address + @event.other_address if @event.zipcode_address.present? && @event.other_address.present?

    if @event.update(event_update_params)
      redirect_to @event
    else
      render :edit
    end
  end

  def destroy
    @event = Event.find(params[:id])

    if @event.destroy
      redirect_to root_path, notice: 'Event was successfully deleted.'
    else
      flash[:alert] = 'Failed to delete the event.'
      render :show
    end
  end

  private

  def event_create_params
    params.require(:event).permit(:name, :zipcode_id, :zipcode_address, :other_address, :place, :price, :people_limit, :description, :held_at,
                                  :deadline_at).merge(master: current_user)
  end

  def event_update_params
    params.require(:event).permit(:name, :zipcode_id, :zipcode_address, :other_address, :place, :price, :people_limit, :description)
  end
end