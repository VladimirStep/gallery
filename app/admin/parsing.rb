ActiveAdmin.register_page 'Parsing' do
  menu priority: 3

  sidebar :parsing do
    form_for :parsing do |f|
      f.label 'Site url'
      f.text_field :url
      br
      br
      f.submit 'Parse'
    end
  end

  # controller do
  #   def index
  #     if request.post?
  #       @url = params[:url]
  #
  #     else
  #       @url = 'Hello!'
  #     end
  #     @url = params[:url]
  #   end
  # end


  content do
    h3 'Enter site url for parsing'

    div @url
  end

  action_item :view_site do
    link_to "View Site", "/"
  end

  # action_item :add do
  #   link_to "Add Event", admin_parsing_add_event_path, method: :post
  # end


  page_action :index, method: :post do
    # ...
    @url = params[:url]
    # redirect_to admin_parsing_path, notice: "Your event was added"
  end

end