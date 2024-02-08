class EventAttendancesController < ApplicationController
  def index
    @event = Event.find(params[:event_id])
    return redirect_to root_path, alert: 'access denied.' if @event.master != current_user

    @attendances = @event.event_attendances.order(created_at: :desc)
    @attendance_count = @attendances.count
    @requested_count = @attendances.requested.count
    @canceled_count = @attendances.canceled.count
    @approved_count = @attendances.approved.count
    @rejected_count = @attendances.rejected.count
  end

  def new
    @attendance = EventAttendance.new(event_id: params[:event_id])
  end

  def create
    event = Event.find(params[:event_id])
    return redirect_to event, alert: '定員に達しているため参加申し込みはできません' unless event.can_request?

    @attendance = EventAttendance.new(attendance_create_params.merge(event:, status: 'requested'))

    if @attendance.save
      EventMailer.with(master: event.master, request_user: current_user, event:).request_email.deliver_now
      Notification.create!(user_id: event.master_id, message: "#{event.name}に#{current_user.name}さんから申請がありました",
                           url: ENV.fetch('MINSAKA_URL', nil) + Rails.application.routes.url_helpers.event_event_attendances_path(event))
      redirect_to event, notice: 'イベント申請が完了しました'
    else
      render :new
    end
  end

  def update
    event = Event.find(params[:event_id])
    attendance = event.event_attendances.find(params[:id])
    if attendance.update(status: params[:status])
      notification_user = attendance.canceled? ? event.master : attendance.user
      EventMailer.with(event: attendance.event, request_user: notification_user, status: attendance.status_text).attendance_email.deliver_now
      Notification.create!(user: notification_user, message: "#{event.name}の申請が#{attendance.status_text}されました",
                           url: ENV.fetch('MINSAKA_URL', nil) + Rails.application.routes.url_helpers.event_path(event))
      redirect_back fallback_location: root_path, notice: "#{attendance.status_text}しました"
    else
      redirect_back fallback_location: root_path, alert: "#{attendance.status_text}に失敗しました"
    end
  end

  private

  def attendance_create_params
    params.require(:event_attendance).permit(:note, :event).merge(user: current_user)
  end
end
