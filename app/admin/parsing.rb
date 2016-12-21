ActiveAdmin.register_page 'Parsing' do
  menu priority: 3

  sidebar :parsing do
    form_for :site, action: admin_parsing_result_path do |f|
      f.label 'Site Url'
      f.text_field :url
      br
      br
      f.submit 'Pars'
    end
  end

  content do
    h3 'Enter site url for parsing'

  end

  action_item :view_site do
    link_to "View Site", "/"
  end

  page_action :result, method: :post do
    # ...
    # @url = params[:url]
    # redirect_to admin_parsing_path, notice: "Your event was added"
  end

end