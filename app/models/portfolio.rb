class Portfolio < ActiveRecord::Base
  belongs_to :user
  has_many :bonus
  has_many :sales
end
