class Standard < User
	has_many :registrations, dependent: :destroy
	has_many :academies, through: :registrations
end