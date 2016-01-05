class Portfolio < ActiveRecord::Base
  belongs_to :user
  has_many :bonuses, class_name: 'Bonus', foreign_key: :portfolio_id, dependent: :destroy
  has_many :stocks, dependent: :destroy
  has_many :sales, dependent: :destroy
  has_many :purchases, dependent: :destroy
  has_many :companies,-> { distinct }, through: :stocks, class_name: "Company", foreign_key: "company_id"

  default_scope { order('created_at DESC') }
  validates :name, :user_id, presence: true
  validates_inclusion_of :active, :in => [true, false]
  accepts_nested_attributes_for :purchases, allow_destroy: true


  def update_purchase_quantity company_id, total_shares
    purchases = self.purchases.where(company_id: company_id)
    if purchases.present?
      purchases.each do |purchase|
        if purchase.quantity > total_shares
          total_shares = purchase.quantity - total_shares
          total_price = total_shares * purchase.price
          purchase.update_attributes(quantity: total_shares, total_price: total_price)
          self.update_portfolio_balance
          return
        elsif purchase.quantity < total_shares
          total_shares = total_shares - purchase.quantity
          purchase.update_attributes(quantity: 0, total_price: 0)
        elsif purchase.quantity == total_shares
          total_shares = total_shares - purchase.quantity
          purchase.update_attributes(quantity: 0, total_price: 0)
          self.update_portfolio_balance
          return
        end
      end
    end
  end

  def update_portfolio_balance
    balance = self.purchases.pluck(:total_price).sum
    self.update_attributes(balance: balance) 
  end
end
