class CreatePaymentCredentials < ActiveRecord::Migration
  def change
    create_table :payment_credentials do |t|
    	t.references :user, index: true, foreign_key: true
    	t.references :plan, index: true, foreign_key: true
    	t.integer :customer_id
    	t.string :last4
    	t.datetime :exp_date
    	t.string :first_name
    	t.string :last_name
    	t.string :pincode
    	t.string :email
    	t.string :phone_number

      t.timestamps
    end
  end
end
