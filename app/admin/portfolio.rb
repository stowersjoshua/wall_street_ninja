ActiveAdmin.register Portfolio do
  permit_params :active, :name
  actions :all, except: [:new]

  form do |f|
    f.semantic_errors *f.object.errors.keys

    f.inputs 'Portfolio' do
      f.input :name, label: 'Name'
      f.input :active, label: 'Active', as: :select, collection: [true, false], include_blank: false
      f.inputs 'Stock' do
        f.semantic_fields_for :purchases do |purchase|
          purchase.input :company_id, label: 'Company Name', as: :select, collection: Company.all.map { |c| [c.name, c.id] }, include_blank: false
          purchase.input :price, label: 'Price'
          purchase.input :quantity, label: 'quantity'
          purchase.input :total_price, label: 'Total Price'
        end
      end
    end
    f.actions
  end
end
