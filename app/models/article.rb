class Article < ActiveRecord::Base
	belongs_to :assignment
	has_many :article_assignments
  has_many :assignments, through: :article_assignments, dependent: :destroy
end
