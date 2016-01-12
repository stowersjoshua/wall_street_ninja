class CreateAcademies < ActiveRecord::Migration
  def change
    create_table :academies do |t|
    	t.string :name
    	t.text :description
    	
      t.timestamps
    end
  end
end
