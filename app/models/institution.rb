class Institution < User # :nodoc:
  has_many :subscriptions, dependent: :destroy
  has_many :academies, through: :subscriptions

  validates :institution_name, :institution_type, presence: true
  accepts_nested_attributes_for :academies, allow_destroy: true
end
