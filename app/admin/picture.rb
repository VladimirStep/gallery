require 'curb'

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

  sidebar :url_parsing, only: [:parsing], priority: 1 do
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

  sidebar :collection_for_parsing, only: [:parsing], priority: 2 do
    form action: parsing_admin_pictures_path, method: :post do
      form_for :site do |f|
        f.label :url, 'Site Name'
        f.collection_select(:url, Site.all, :address, :name)
        br
        br
        f.submit 'Parse'
      end
    end
  end

  collection_action :parsing, method: [:get, :post] do
    if request.get?
      render 'parsing_get'
    else
      @images = []
      url = params[:site][:url]
      http = Curl.get(url)
      doc = Nokogiri::HTML(http.body_str)
      doc.css('img').each do |image|
        @images.push(image['src']) if /^http/.match(image['src'])
      end
      @@pass = @images
      render 'parsing_post'
    end
  end

  action_item :parsing, only: [:index] do
    link_to 'Parsing', parsing_admin_pictures_path, method: :get
  end

  action_item :pictures, only: [:parsing] do
    link_to 'Pictures', admin_pictures_path, method: :get
  end

  collection_action :load_pictures, method: :post do
    @images = @@pass
    params[:picture][:url].each do |index, status|
      if status == '1'
        Picture.create!(category_id: params[:picture][:category].to_i, remote_image_url: @images[index.to_i].to_s)
      end
    end
    redirect_to admin_pictures_path
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
