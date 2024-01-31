class EventAttendancesController < ApplicationController
  def index
    @event = Event.find(params[:event_id])
    return redirect_to root_path, alert: 'access denied.' if @event.master != current_user

    @attendances = @event.event_attendances.order(created_at: :desc)
    @attendance_count = @attendances.count
    @request_count = @attendances.where(status: 'request').count
    @approve_count = @attendances.where(status: 'approve').count
    @reject_count = @attendances.where(status: 'reject').count
  end

  def new
    @attendance = EventAttendance.new
  end

  def create
    event = Event.find(params[:event_id])
    @attendance = EventAttendance.new(attendance_create_params.merge(event:, status: 'request'))

    if @attendance.save
      # TODO: メールか通知機能
      redirect_to event
    else
      render :new
    end
  end

  def update
    event = Event.find(params[:event_id])
    attendance = event.event_attendances.find(params[:id])
    if attendance.update(status: params[:status])
      # TODO: メールか通知機能
      redirect_to event_event_attendances_path(event)
    else
      render :new
    end
  end

  private

  def attendance_create_params
    params.require(:event_attendance).permit(:note, :event).merge(user: current_user)
  end
end
