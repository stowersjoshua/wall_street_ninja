class Subscription < ActiveRecord::Base # :nodoc:
  belongs_to :institution
  belongs_to :academy
  belongs_to :plan

  validates :institution_id, presence: true
end
