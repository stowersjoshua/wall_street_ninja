class Portfolio < ActiveRecord::Base
  belongs_to :user
  has_many :bonuses, class_name: 'Bonus', foreign_key: :bonus_id, dependent: :destroy
  has_many :stocks, dependent: :destroy
  # has_many :companies, dependent: :destroy

  validates :name, :user_id, presence: true
  validates_inclusion_of :active, :in => [true, false]
  accepts_nested_attributes_for :stocks, allow_destroy: true
  after_save :update_balance

  def update_balance
  	# self.balance = self.stocks.
  end
end
