class DynamicLinks::DynamicLinksController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:update_status]

  def send_to
    # TODO - Add active check
    if dynamic_link_params[:id]
      dynamic_link = DynamicLinks::DynamicLink.fetch_link(dynamic_link_params[:id])
      url = dynamic_link.build_redirect if dynamic_link
      redirect_to(url) and return if url
    end
    raise ActionController::RoutingError.new('Not Found')
  end

  def index
    @links = DynamicLinks::DynamicLink.all
  end

  def update_status
    # TODO- Add ajax check
    link = DynamicLinks::DynamicLink.find_by(link_key: update_link_params[:id])
    link.active = update_link_params[:status]
    link.save!
    render json:{msg: "done"}, status: :ok
  end

  private

  def dynamic_link_params
    params.permit(:id)
  end

  def update_link_params
    params.permit(:id, :status)
  end
end
