ActiveAdmin.register Article do
  permit_params :title, :author, :summary

  form do |f|
    f.inputs do
      f.input :title
      f.input :author
      f.input :summary, as: :ckeditor
    end
    f.actions
  end
end
