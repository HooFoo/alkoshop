ActiveAdmin.register DiscountCard do
  permit_params :number, :user_name, :user_email, :discount

  index do
    selectable_column
    id_column
    column :number
    column :user_name
    column :user_email
    column :discount
    column :user
    actions
  end

  filter :number
  filter :user_name
  filter :user_email
  filter :discount

  form do |f|
    f.inputs "Discount card details" do
      f.input :number
      f.input :user_name
      f.input :user_email
      f.input :discount, as: :select, collection: DiscountCard::DISCOUNTS.keys
    end
    f.actions
  end
end
