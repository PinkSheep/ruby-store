class Product < ActiveRecord::Base
  has_many :line_items

  before_destroy :ensure_not_referenced_by_any_line_item

  validates :title, :description, :image_url, presence: true
  validates :price, numericality: {greater_than_or_equal_to: 0.05}
  validates :title, uniqueness: true
  validates :image_url, allow_blank: true, format: {
    with:    %r{\.(gif|jpg|png)\Z}i,
    message: 'must be an URL for GIF, JPG or PNG image.'
  }
  validate :price_in_steps

  def price_in_steps
    if price and price % 0.05 != 0.0
      errors.add(:price, 'no smaller entity than 0.05.')
    end
  end 

  def self.latest
    Product.order(:updated_at).last
  end

  private

  # ensure that there are no line items referencing this product
  def ensure_not_referenced_by_any_line_item
    if line_items.empty?
      return true
    else
      errors.add(:base, 'Line items present')
      return false
    end
  end
end
