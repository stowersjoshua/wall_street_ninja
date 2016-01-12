class CreatePlans < ActiveRecord::Migration
  def change
    create_table :plans do |t|
    	t.string :name
    	t.integer :registration_limit, default: 0
    	t.float :price
    	t.text :description

      t.timestamps
    end
  end
end
