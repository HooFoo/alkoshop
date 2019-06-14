ActiveAdmin.register Item do
  permit_params  :name, :image, :price, :type_extra, :region, :facturer,
                 :alcohol, :source, :description, :promote, :article, :barcode,
                 :brand_id, :type_id, :country_id, :in_stock, :created_at,
                 :items_volumes_attributes => [:id, :volume_id, :price, :_destroy]

  csv do
    column :id, humanize_name: false
    column('Название') { |i| "\"#{i.name}, #{i.type_extra}\"" }
    column('Производитель') { |i| "\"#{i.brand}\"" }
    column('Категория') { |i| "\"#{i.type}\"" }
    column('Ссылка на товар на сайте магазина') do |i|
      "https://stashstore.ru/shop/catalog?brand=#{i.brand_id}&type=#{i.type_id}&country=#{i.country_id}#item=#{i.id}"
    end
    column ('цена'), &:price
    column('Старая цена (до скидки)') { '' }
    column('Валюта') {'RUR'}
    column('Ссылка на картинку') { |i| "#{i.image.url}" }
    column('Характеристики товара') {|i| "Объем|#{i.items_volumes.first.volume.ml.to_f/1000}|л;"}
    column ('Штрихкод'), &:barcode
    column('Самовывоз') { 'Есть' }
    column('Стоимость самовывоза') { 0 }
    column('Срок самовывоза') { '1-2' }
    column('Описание') { |i| "\"#{i.description}\"" }
    column('Условия продажи') { "" }
    column('Страна происходжения') { |i| "#{i.country}" }
    column(:bid, humanize_name: false) { }
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
