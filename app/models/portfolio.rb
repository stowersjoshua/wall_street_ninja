class Portfolio < ActiveRecord::Base # :nodoc:
  belongs_to :user
  has_many :bonuses, class_name: 'Bonus', foreign_key: :portfolio_id,
                     dependent: :destroy

  has_many :stocks, dependent: :destroy
  has_many :sales, dependent: :destroy
  has_many :purchases, dependent: :destroy
  has_many :companies, -> { distinct }, through: :stocks, class_name: 'Company',
                                        foreign_key: 'company_id'

  validates :name, :user_id, presence: true
  validates_inclusion_of :active, in: [true, false]
  accepts_nested_attributes_for :purchases, allow_destroy: true
  default_scope { order('created_at DESC') }

  def update_purchase(purchase, quantity)
    if purchase.quantity > quantity
      total_stock = purchase.quantity - quantity
      total_price = total_stock * purchase.price
      purchase.update_attributes(quantity: total_stock,
                                 total_price: total_price)
    elsif purchase.quantity == quantity
      purchase.destroy
    end
  end
end
