class Assignment < ActiveRecord::Base # :nodoc:
  belongs_to :academy
  has_many :article_assignments
  has_many :articles, through: :article_assignments, dependent: :destroy
end
