class EventCommentsController < ApplicationController
  def index
    @event = Event.find(params[:event_id])
    return redirect_to root_path, alert: 'access denied.' unless @event.master == current_user || @event.approved_user?(current_user)

    @comments = @event.event_comments.order(created_at: :desc)
    @comment = EventComment.new
  end

  def create
    event = Event.find(params[:event_id])
    comment = EventComment.new(comment_create_params.merge(event:))

    if comment.save
      redirect_to event_event_comments_path(event)
    else
      render :new
    end
  end

  private

  def comment_create_params
    params.require(:event_comment).permit(:content).merge(user: current_user)
  end
end
