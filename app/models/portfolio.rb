class Portfolio < ActiveRecord::Base
  belongs_to :user
  has_many :bonuses, class_name: 'Bonus', foreign_key: :portfolio_id, dependent: :destroy
  has_many :stocks, dependent: :destroy
  has_many :sales, dependent: :destroy
  has_many :purchases, dependent: :destroy
  has_many :companies,-> { distinct }, through: :stocks, class_name: "Company", foreign_key: "company_id"

  # def companies
  # 	companies
  # end
  default_scope { order('created_at DESC') }
  validates :name, :user_id, presence: true
  validates_inclusion_of :active, :in => [true, false]
  accepts_nested_attributes_for :stocks, allow_destroy: true
end
