class ReservationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_room, only: [ :new, :create, :confirm ]
  def index
    @reservations = current_user.reservations.includes(:room)
  end

  def new
    @reservation = Reservation.new
  end

  def create
    @reservation = Reservation.new(reservation_params)
    @reservation.user = current_user
    @reservation.room = @room

    if @reservation.save
      flash[:notice] = "予約が完了しました"
      redirect_to room_reservations_path(@room)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def confirm
    @reservation = Reservation.new(reservation_params)
    @reservation.user = current_user
    @reservation.room = @room

    unless @reservation.valid?
      render "rooms/show", status: :unprocessable_entity
    end
  end

  private

  def set_room
    @room = Room.find(params[:room_id])
  end

  def reservation_params
    params.require(:reservation).permit(:check_in_date, :check_out_date, :guest_count)
  end
end
