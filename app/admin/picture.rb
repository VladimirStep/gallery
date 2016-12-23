ActiveAdmin.register Picture do
  menu priority: 2
# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
  permit_params :image, :category_id
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if params[:action] == 'create' && current_user.admin?
#   permitted
# end

  sidebar :parsing do
    form action: parsing_admin_pictures_path, method: :post do
      form_for :site do |f|
        f.label :url, 'Site Url'
        f.text_field :url
        br
        br
        f.submit 'Parse'
      end
    end
  end

  collection_action :parsing, method: :post do
    url = params[:site][:url]
    doc = Nokogiri::HTML(open(url))
    @images = doc.css('a img')
  end

  filter :category_category_name, as: :select, collection: -> { Category.all.map { |c| c.category_name } }, label: 'Category'
  filter :created_at
  filter :updated_at

  index as: :grid, columns: 4 do |picture|
    div link_to image_tag(picture.image.thumb.url), admin_picture_path(picture)
    resource_selection_cell picture
  end

  index do
    selectable_column
    id_column
    column :image
    column :created_at
    column :updated_at
    actions
  end
end
