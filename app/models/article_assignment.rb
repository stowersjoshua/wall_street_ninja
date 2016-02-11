class ArticleAssignment < ActiveRecord::Base
	belongs_to :article
	belongs_to :assignment
end
