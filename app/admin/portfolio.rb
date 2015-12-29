ActiveAdmin.register Portfolio do
  permit_params :balance, :active, :name

  form do |f|
		f.semantic_errors *f.object.errors.keys

		f.inputs "Portfolio" do
			f.input :name, label: "Name"
			f.input :active, label: "Active", as: :select, collection: [true, false], include_blank: false
			f.input :balance
			f.inputs "Stock" do
				f.semantic_fields_for :stocks do |stock|
					stock.input :company_id, label: "Company Name", as: :select, collection: Company.all.map{|c| [c.name, c.id]}, include_blank: false
					stock.input :price, label: "Price"
					stock.input :quantity, label: "quantity"
					stock.input :total_price, label: "Total Price"
				end
			end
		end
		f.actions
	end
end