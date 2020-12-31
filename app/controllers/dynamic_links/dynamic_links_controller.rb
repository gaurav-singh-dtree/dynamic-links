class DynamicLinks::DynamicLinksController < ApplicationController
  skip_before_action :verify_authenticity_token

  def send_to
    if params[:id]
      dynamic_link = DynamicLinks::DynamicLink.fetch_link(params[:id])
      url = dynamic_link.build_redirect if dynamic_link
      params.except(:id)
      redirect_to(url) and return if url
    end
    raise ActionController::RoutingError.new('Not Found')
  end

  def index
    @links = DynamicLinks::DynamicLink.all
  end

  def update_status
    link = DynamicLinks::DynamicLink.find_by(link_key: params[:id])
    link.active = params[:status]
    link.save!
    render json:{msg: "done"}, status: :ok
  end
end
