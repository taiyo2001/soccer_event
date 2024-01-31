class EventAttendancesController < ApplicationController
  def new
    @attendance = EventAttendance.new
  end

  def create
    event = Event.find(params[:id])
    @attendance = EventAttendance.new(attendance_create_params.merge(event:))

    if @event.save
      redirect_to @attendance
    else
      render :new
    end
  end

  private

  def attendance_create_params
    params.require(:event_attendance).permit(:note, :event).merge(user: current_user)
  end
end
