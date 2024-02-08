class EventMailer < ApplicationMailer
  default from: 'from@example.com'

  def request_email
    @event = params[:event]
    @master = params[:master]
    @request_user = params[:request_user]
    mail(to: @master.email, subject: 'イベントに参加申請が届きました')
  end

  def attendance_email
    @event = params[:event]
    @request_user = params[:request_user]
    @status = params[:status]
    mail(to: @request_user.email, subject: "イベントが#{@status}されました")
  end

  def event_comment_email
    @mentioned_user = params[:mentioned_user]
    @mentioning_user = params[:mentioning_user]
    @event = params[:event]
    mail(to: @mentioned_user.email, subject: "コメントで#{@mentioning_user.name}さんからメンションされました")
  end

  def team_comment_email
    @mentioned_user = params[:mentioned_user]
    @mentioning_user = params[:mentioning_user]
    @team = params[:team]
    mail(to: @mentioned_user.email, subject: "コメントで#{@mentioning_user.name}さんからメンションされました")
  end
end
