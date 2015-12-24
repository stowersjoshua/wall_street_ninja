ActiveAdmin.register User do
  permit_params :email, :active, :encrypted_password, :reset_password_token, :reset_password_sent_at, :remember_created_at, :sign_in_count, :current_sign_in_at, :last_sign_in_at, :username, :first_name, :last_name, :city, :state


  index do
    selectable_column
    id_column
    column :username
    column :first_name
    column :last_name
    column :email
    column :current_sign_in_at
    column :sign_in_count
    column :created_at
    column :active
    actions
  end

  filter :username
  filter :first_name
  filter :last_name
  filter :email
  filter :current_sign_in_at
  filter :sign_in_count
  filter :created_at
  filter :active

  form do |f|
    f.inputs "Admin Details" do
    	f.input :username
    	f.input :first_name
    	f.input :last_name
    	f.input :active, as: :select, collection: [true, false], include_blank: false
      f.input :email
      f.input :password
      f.input :password_confirmation
    end
    f.actions
  end
end
