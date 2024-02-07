class EventsController < ApplicationController
  skip_before_action :set_search_event_form, only: %i[applied]
  before_action :search_modal_open?, only: %i[index applied]

  # TODO: 各イベントリストを返すエンドポイントでフリーワードでスペース区切りでできるようにする

  def index
    @q = current_user.not_applied_events.open.ransack(params[:q])
    @q.sorts = 'created_at asc' if params[:q].blank? || params[:q][:s].blank?
    @events = @q.result(distinct: true).order(created_at: :asc).page(params[:page]).per(10)
    @prefectures = Prefecture.all
  end

  def applied
    @q = current_user.applied_events.open.ransack(params[:q])
    @q.sorts = 'created_at asc' if params[:q].blank? || params[:q][:s].blank?
    @events = @q.result(distinct: true).order(created_at: :asc).page(params[:page]).per(10)
    @prefectures = Prefecture.all
  end

  def attendance
    @q = current_user.events.approved.ransack(params[:q])
    @q.sorts = 'held_at asc' if params[:q].blank? || params[:q][:s].blank?
    @events = @q.result(distinct: true).order(created_at: :asc).page(params[:page]).per(10)
    @prefectures = Prefecture.all
  end

  def mine
    @q = current_user.events.ransack(params[:q])
    @q.sorts = 'held_at desc' if params[:q].blank? || params[:q][:s].blank?
    @events = @q.result(distinct: true).order(created_at: :asc).page(params[:page]).per(10)
    @prefectures = Prefecture.all
  end

  def favorite
    @q = current_user.favorite_events.ransack(params[:q])
    @q.sorts = 'held_at asc' if params[:q].blank? || params[:q][:s].blank?
    @events = @q.result(distinct: true).order(created_at: :asc).page(params[:page]).per(10)
    @prefectures = Prefecture.all
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

      @event.zipcode_address = "#{zipcode.prefecture&.name}#{zipcode.city&.name}#{zipcode.town&.name}"
      @event.zipcode = zipcode
      return render :new
    end

    @event.address = @event.zipcode_address + @event.other_address if @event.zipcode_address.present? && @event.other_address.present?

    if @event.save
      redirect_to @event, notice: 'イベントを作成しました'
    else
      render :new
    end
  end

  def show
    @event = Event.find(params[:id])
    @attendance = @event.event_attendances.find_by(user: current_user)
    @is_approve = @event.approved_user?(current_user)
    @comments = @event.event_comments.order(created_at: :desc).limit(5)
  end

  def edit
    @event = Event.find(params[:id])
    zipcode = @event.zipcode
    @event.zipcode_address = "#{zipcode.prefecture.name}#{zipcode.town.city.name}#{zipcode.town.name}"
    @event.other_address = @event.address.sub(@event.zipcode_address, '')
    @editable = false
  end

  def update
    @event = Event.find(params[:id])

    if params[:search_address].present?
      zipcode = Zipcode.find_by(id: event_create_params[:zipcode_id])
      @event.errors.add(:zipcode_id, '郵便番号を再検索してください') if zipcode.nil?

      @event.zipcode_address = "#{zipcode.prefecture&.name}#{zipcode.city&.name}#{zipcode.town&.name}"
      @event.zipcode = zipcode
      return render :edit
    end

    @event.address = @event.zipcode_address + @event.other_address if @event.zipcode_address.present? && @event.other_address.present?

    if @event.update(event_update_params)
      redirect_to @event, notice: 'イベントを更新しました'
    else
      render :edit
    end
  end

  def destroy
    @event = Event.find(params[:id])

    if @event.destroy
      redirect_to root_path, notice: 'イベントを削除しました'
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

  def search_modal_open?
    @modal_open = params[:q].present? &&
                  (params[:q][:price_gteq].present? ||
                    params[:q][:price_lteq].present? ||
                    params[:q][:people_limit_gteq].present? ||
                    params[:q][:people_limit_lteq].present?)
  end
end
