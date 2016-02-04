class Institution < User
	has_many :subscriptions, dependent: :destroy
	has_many :academies, through: :subscriptions
	
	validates :institution_name, :institution_type, presence: true
end