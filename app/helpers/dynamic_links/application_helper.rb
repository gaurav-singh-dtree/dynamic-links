module DynamicLinks
  module ApplicationHelper
    def create_row(link)
      row_class = link.valid_link? ? "row" : "row invalid"
      content = content_tag(:tr, class: row_class) do
        concat(tag.td link.id, class: 'row-data')
        concat(tag.td link_to(link.generate_link, link.generate_link, target: "_blank"), class: 'row-data')
        concat(tag.td link.about, class: 'row-data')
        concat(tag.td link.expires_at, class: 'row-data')
        concat(tag.td create_button_content(link), class: 'row-data')
      end.html_safe
      content
    end

    def create_button_content(link)
      if !link.expired?
        button_class = link.active? ? "actions-disable" : "actions-activate"
        link_text = link.active? ? 'Disable' : 'Activate'
        tag.button(
          link_text,
          class: button_class,
          data: {
            link_key: link.link_key,
            link_status: link.active
          }
        )
      else
        "Expired Link"
      end
    end
  end
end
