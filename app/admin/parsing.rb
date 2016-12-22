ActiveAdmin.register_page 'Parsing' do
  menu priority: 3

  sidebar :parsing do
    form action: admin_parsing_result_path, method: :post do
      form_for :site do |f|
        f.label :url, 'Site Url'
        f.text_field :url
        br
        br
        f.submit 'Pars'
      end
    end
  end

  content do
    h3 'Enter site url for parsing'


  end

  action_item :view_site do
    link_to 'View Site', '/'
  end



  page_action :result, method: :post do
    @url = params[:site][:url]

    # ...
    # html = Arbre::Context.new do
    #   div @url
    # end
    # html
    # redirect_to admin_parsing_path, notice: 'Parsed succeffuly'
  end

end