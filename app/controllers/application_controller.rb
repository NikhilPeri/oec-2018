class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def render_400
    render file: "#{Rails.root}/public/404.html", layout: false, status: 404
  end

  def authenticate_admin
    @admin = Admin.find(session[:admin_id]) if session[:admin_id]
    redirect_to '/admin/login_form' unless  @admin
  end

  def authenticate_broker
    @broker = Broker.find(params[:token])
    render_404 unless @broker
  end
end
