class CreateRegistrations < ActiveRecord::Migration
  def change
    create_table :registrations do |t|
    	t.references :standard, index: true, foreign_key: true 
    	t.references :academy, index: true, foreign_key: true 
    	t.string :status, default: 'pending'

      t.timestamps
    end
  end
end
