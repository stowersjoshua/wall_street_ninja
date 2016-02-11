class Company < ActiveRecord::Base # :nodoc:
  has_many :stocks, dependent: :destroy

  validates :cik_code, :sic_code, :name, :description, :city, :state, presence: true
  scope :by_search, lambda { |search| where('lower(name) LIKE ? OR lower(city) LIKE ? OR lower(state) LIKE ?', "%#{search}%", "%#{search}%", "%#{search}%") if search.present?}
end
