class Institution < User
	has_many :subscriptions, dependent: :destroy
	has_many :academies, through: :subscriptions
end