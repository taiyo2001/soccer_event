class FavoritesController < ApplicationController
  def create
    @favorite = Favorite.new(user: current_user, event_id: params[:event_id])
    @favorite.save!

    @event = Event.find(params[:event_id])
    respond_to do |format|
      format.html { redirect_to events_path }
      format.turbo_stream
    end
  end

  def destroy
    @favorite = Favorite.find(params[:id])
    @favorite.destroy!

    @event = Event.find(params[:event_id])
    respond_to do |format|
      format.html { redirect_to events_path }
      format.turbo_stream
    end
  end
end
