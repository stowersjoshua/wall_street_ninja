class Registration < ActiveRecord::Base # :nodoc:
  belongs_to :user
  belongs_to :academy

  validates :user_id, :reg_type, presence: true
end
