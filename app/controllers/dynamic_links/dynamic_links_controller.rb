class DynamicLinks::DynamicLinksController < ApplicationController
  helper DynamicLinks::ApplicationHelper

  def send_to
    if params[:id]
      DynamicLink::RequestTrackerService.call(request) # Track the source of the request
      dynamic_link = DynamicLinks::DynamicLink.fetch_link(params[:id])
      url = dynamic_link&.build_redirect_link
      redirect_to(url) and return if url
    end
    raise ActionController::RoutingError.new('Not Found')
  end

  def index
    @links = DynamicLinks::DynamicLink.all
  end

  def update_status
    return render json:{error: "Not a valid request"}, status: :bad_request unless request.xhr?

    link = DynamicLinks::DynamicLink.find_by(link_key: params[:id])
    link.active = params[:status]
    link.save!
    render json:{msg: "done"}, status: :ok
  end
end
