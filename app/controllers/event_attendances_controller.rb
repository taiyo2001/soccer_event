class EventAttendancesController < ApplicationController
  SOCCER_EVENT_URL = 'http://localhost:3000'

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
      EventMailer.with(master: event.master, request_user: current_user, event:).request_email.deliver_now
      Notification.create!(user_id: event.master_id, message: "#{event.name}に#{current_user.name}さんから申請がありました", url: SOCCER_EVENT_URL + Rails.application.routes.url_helpers.event_event_attendances_path(event))
      redirect_to event
    else
      render :new
    end
  end

  def update
    event = Event.find(params[:event_id])
    attendance = event.event_attendances.find(params[:id])
    if attendance.update(status: params[:status])
      EventMailer.with(event: attendance.event, request_user: attendance.user, status: attendance.status_text).attendance_email.deliver_now
      Notification.create!(user: attendance.user, message: "#{event.name}の申請が#{attendance.status_text}されました", url: SOCCER_EVENT_URL + Rails.application.routes.url_helpers.event_path(event))
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
