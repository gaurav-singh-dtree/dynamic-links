class DynamicLinks::DynamicLinksController < ApplicationController
  def send_to
    if params[:id]
      dynamic_link = DynamicLinks::DynamicLink.fetch_link(params[:id])
      url = dynamic_link.build_redirect if dynamic_link
      params.except(:id)
      redirect_to(url) and return if url
    end
    raise ActionController::RoutingError.new('Not Found')
  end
end
