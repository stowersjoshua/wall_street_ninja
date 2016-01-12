class CreateSubscriptions < ActiveRecord::Migration
  def change
    create_table :subscriptions do |t|
    	t.references :institution, index: true, foreign_key: true 
    	t.references :plan, index: true, foreign_key: true 
    	t.references :academy, index: true, foreign_key: true 
    	t.boolean :status, default: false
    	
      t.timestamps
    end
  end
end
