class Portfolio < ActiveRecord::Base
  belongs_to :user
  has_many :bonuses, class_name: 'Bonus', foreign_key: :portfolio_id, dependent: :destroy
  has_many :stocks, dependent: :destroy

  default_scope { order('created_at DESC') }
  validates :name, :user_id, presence: true
  validates_inclusion_of :active, :in => [true, false]
  accepts_nested_attributes_for :stocks, allow_destroy: true
end
