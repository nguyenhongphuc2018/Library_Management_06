class Borrow < ApplicationRecord
  belongs_to :user
  has_many :book_borrows, dependent: :destroy
  has_many :books, through: :book_borrows

  validate :start_date_before_end_date
  validate :start_date_after_now
  validates :start_date, :end_date, presence: true

  accepts_nested_attributes_for :book_borrows

  scope :check_approve, ->(boolean_approve){where(approve: boolean_approve)}
  scope :order_by_time, ->{order(:start_date, :end_date, created_at: :asc)}

  private
  def start_date_before_end_date
    return unless start_date > end_date
    errors.add(:end_date, Settings.borrow.validate_date)
  end

  def start_date_after_now
    if start_date > Time.now
      if end_date > start_date + Settings.borrow.day.days
        errors.add(:end_date, Settings.borrow.not_over_7_days)
      end
    else
      errors.add(:start_date, Settings.borrow.bigger_time_now)
    end
  end
end
