class Cat < ActiveRecord::Base
  COLORS = %w(red green blue)

  validates :birth_date, :color, :name, :sex, presence: true
  validates :color, inclusion: { in: COLORS }
  validates :sex, inclusion: { in: %w(M F) }

  has_many(
    :cat_rentals,
    class_name: 'CatRentalRequest',
    foreign_key: :cat_id,
    primary_key: :id,
    dependent: :destroy
  )

  def self.colors
    COLORS
  end

  def age
    Date.today.year - self.birth_date.year
  end
end
