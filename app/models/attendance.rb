class Attendance < ApplicationRecord
  belongs_to :user

  validates :worked_on, presence: true

  # 出勤時間が存在しない場合、退勤時間は無効
  validate :finished_at_is_invalid_without_a_started_at
  validate :started_at_and_finished_at


  def finished_at_is_invalid_without_a_started_at
    errors.add(:started_at, "が必要です") if started_at.blank? && finished_at.present?
  end
  
  def started_at_and_finished_at
    if started_at.present? && finished_at.present?
      errors.add(:started_at, "より早い時間は無効です") if finished_at < started_at
    end
  end
  
end
