class Portfolio < ActiveRecord::Base
  belongs_to :user
  has_many :bonuses, class_name: 'Bonus', foreign_key: :bonus_id, dependent: :destroy
  has_many :stocks, dependent: :destroy

  validates :name, :balance, :active, :user_id, presence: true
end
