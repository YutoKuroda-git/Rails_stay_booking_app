class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :room

  validates :check_in_date, :check_out_date, :guest_count, presence: true
  validates :guest_count, numericality: { greater_than_or_equal_to: 1 }
  validate :check_in_date_is_today_or_later
  validate :check_out_date_is_after_check_in

  def stay_days
    (check_out_date - check_in_date).to_i
  end

  def total_price
    room.price_per_night * stay_days * guest_count
  end

  private

  def check_in_date_is_today_or_later
    return if check_in_date.blank?
    if check_in_date < Date.today
      errors.add(:check_in_date, "本日以降の日付を選択してください")
    end
  end

  def check_out_date_is_after_check_in
    return if check_in_date.blank? || check_out_date.blank?
    if check_out_date <= check_in_date
      errors.add(:check_out_date, "チェックイン日より後の日付を選択してください")
    end
  end
end
