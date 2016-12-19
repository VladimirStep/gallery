ActiveAdmin.register_page 'Parsing' do
  menu priority: 3




  sidebar :help do
    "Need help? Email us at help@example.com"
  end

  sidebar :help do
    ul do
      li "Second List First Item"
      li "Second List Second Item"
    end
  end

  content do
    para 'Hello World'

  end

  action_item :view_site do
    link_to "View Site", "/"
  end

  action_item :add do
    link_to "Add Event", admin_parsing_add_event_path, method: :post
  end


  page_action :add_event, method: :post do
    # ...
    redirect_to admin_parsing_path, notice: "Your event was added"
  end

end