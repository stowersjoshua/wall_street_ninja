class CreateArticleAssignments < ActiveRecord::Migration
  def change
    create_table :article_assignments do |t|
    	t.references :article, index: true, foreign_key: true
    	t.references :assignment, index: true, foreign_key: true
      t.timestamps
    end
  end
end
