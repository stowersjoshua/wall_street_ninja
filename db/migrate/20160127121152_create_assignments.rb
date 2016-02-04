class CreateAssignments < ActiveRecord::Migration
  def change
    create_table :assignments do |t|
    	t.references :academy, index: true
    	t.string :title
    	t.string :assignment_type
    	t.text :description
    	t.datetime :due_date
      
      t.timestamps
    end
  end
end
