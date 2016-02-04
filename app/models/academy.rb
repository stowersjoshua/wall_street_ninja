class Academy < ActiveRecord::Base
	has_one :subscription, dependent: :destroy
	has_one :owner, through: :subscription, foreign_key: "institution_id", source: :institution, dependent: :destroy

	has_many :registrations, dependent: :destroy
	has_many :moderatores, -> {where("registrations.reg_type = 'Institution'")}, through: :registrations, source: :user, dependent: :destroy
	has_many :students, -> {where("registrations.reg_type = 'Standard'")}, through: :registrations, source: :user, dependent: :destroy
	has_many :assignments, dependent: :destroy

	validates_uniqueness_of :name
	accepts_nested_attributes_for :subscription, allow_destroy: true
end