module DynamicLinks
  module ApplicationHelper
    def create_row(link)
      content_tag(:tr) do
        content_tag(:td, link.generate_link)
        content_tag(:td, create_button(link))
      end
    end

    def create_button(link)
      content_tag(
        :button,
        link.active ? 'Disable' : 'Activate',
        class: 'actions',
        data: {
          link_key: link.link_key,
          link_status: link.active
        }
      )
    end
  end
end