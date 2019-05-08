ActiveAdmin.register Item do
  permit_params  :name, :image, :price, :type_extra, :region, :facturer,
                 :alcohol, :source, :description, :promote, :article, :barcode,
                 :brand_id, :type_id, :country_id, :in_stock, :created_at,
                 :items_volumes_attributes => [:id, :volume_id, :price, :_destroy]

  csv do
    column(:type, humanize_name: false) { 'alco' }
    column :id, humanize_name: false
    column(:available, humanize_name: false) {|i| i.in_stock ? i.in_stock > 0 : false }
    column(:delivery, humanize_name: false) { 'false' }
    column(:pickup, humanize_name: false) { 'true' }
    column(:store, humanize_name: false) { 'true' }
    column(:url, humanize_name: false) do |i|
      "https://stashstore.ru/shop/catalog?brand=#{i.brand_id}&type=#{i.type_id}&country=#{i.country_id}#item=#{i.id}"
    end
    column(:vendor, humanize_name: false) { |i| "\"#{i.brand}\"" }
    column(:name, humanize_name: false) { |i| "#{i.name}, #{i.type_extra}" }
    column(:category, humanize_name: false) { |i| "\"#{i.type}\"" }
    column :price, humanize_name: false
    column(:oldprice, humanize_name: false) { '' }
    column(:currencyId, humanize_name: false) {'RUR'}
    column(:picture, humanize_name: false){ |i| "\"#{i.image.url}\"" }
    column :description, humanize_name: false
    column(:param, humanize_name: false) {|i| "\"Объем|#{1000/i.items_volumes.first.volume.ml}|л;\""}
    column(:country_of_origin, humanize_name: false) { |i| "\"#{i.country}\"" }
    column :barcode, humanize_name: false
    column(:age, humanize_name: false) { '18' }
  end

  form do |f|
    f.semantic_errors # shows errors on :base
    f.actions
    f.inputs 'Items' do
      f.input :name
      f.input :image
      f.input :price
      f.input :type_extra
      f.input :region
      f.input :facturer
      #f.input :volumes, :as => :select, :input_html => {:multiple => true}
      f.input :brand, :as => :select
      f.input :type, :as => :select
      f.input :country, :as => :select
      f.input :alcohol
      f.input :source
      f.input :description
      f.input :promote
      f.input :article
      f.input :in_stock
      f.input :created_at
      f.input :barcode
    end
    f.inputs do
      f.has_many :items_volumes do |item_volume|
        if !item_volume.object.nil?
          # show the destroy checkbox only if it is an existing appointment
          # else, there's already dynamic JS to add / remove new appointments
          item_volume.input :_destroy, :as => :boolean, :label => "Destroy?",
                            input_html: { disabled: !item_volume.object.special.nil? }
        end
        item_volume.input :special, input_html: { disabled: true }

        item_volume.input :volume, :collection => Volume.all# it should automatically generate a drop-down select to choose from your existing patients
        item_volume.input :price
      end
    end

  end
end
