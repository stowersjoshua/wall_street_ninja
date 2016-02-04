class CreateRegistrations < ActiveRecord::Migration
  def change
    create_table :registrations do |t|
    	t.references :user, index: true, foreign_key: true 
    	t.references :academy, index: true, foreign_key: true 
    	t.string :status, default: 'pending'
    	t.string :reg_type

      t.timestamps
    end
  end
end
