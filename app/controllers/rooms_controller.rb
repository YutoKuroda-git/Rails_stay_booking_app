class RoomsController < ApplicationController
  before_action :authenticate_user!, only: [ :new, :create, :registered ]
  def index
  end

  def new
    @room = Room.new
  end

  def create
    @room = current_user.rooms.build(room_params)
    if @room.save
      flash[:notice] = "施設を登録しました"
      redirect_to @room
    else
      render "new", status: :unprocessable_entity
    end
  end

  def show
    @room = Room.find(params[:id])
    @reservation = Reservation.new
  end

  def search
    @rooms = Room.all

    if params[:area].present?
      @rooms = @rooms.where("address LIKE ?", "%#{params[:area]}%")
    end

    if params[:keyword].present?
      keyword = "%#{params[:keyword]}%"
      @rooms = @rooms.where(
        "name LIKE ? OR description LIKE ?",
        keyword, keyword
      )
    end

    @count = @rooms.count
  end

  def registered
    @rooms = current_user.rooms
  end

  private

  def room_params
    params.require(:room).permit(:name, :description, :price_per_night, :address, :image)
  end
end
