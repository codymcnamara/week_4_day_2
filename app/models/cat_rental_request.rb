class CatRentalRequest < ActiveRecord::Base
  validates :status, inclusion: { in: %w[PENDING APPROVED DENIED] }
  validate :not_double_booked
  after_initialize :default_pending

  belongs_to(
    :cat,
    class_name: 'Cat',
    foreign_key: :cat_id,
    primary_key: :id
  )

  def default_pending
    status ||= "PENDING"
  end

  def overlapping_requests
    overlaps = CatRentalRequest.where("cat_id = ? AND ((start_date BETWEEN ? AND ?)
    OR (end_date BETWEEN ? AND ?) OR (? BETWEEN start_date AND end_date))",
    cat_id, start_date, end_date, start_date, end_date, start_date)

    overlaps
  end

  def not_double_booked
    approved_rentals = overlapping_requests.where(status: 'APPROVED')
    unless approved_rentals.count == 0
      errors[:base] << "time conflict with previous booking!"
    end
  end



  private

end
