class AdminController < ApplicationController
  before_action :load_from_session, except: %w(new create authenticate)

  def new
    @admin = Admin.new
  end

  def create
    @admin = Admin.new(signup_params)

    if @admin.save
        redirect_to '/admin'
    else
      render '/admin/new'
    end
  end

  def authenticate
    @admin = Admin.find_by_email(params[:admin][:email])

    if @admin && @admin.authenticate(params[:admin][:password])
      session[:admin_id] = @admin.id
      redirect_to '/admin'
    else
      @errors = ["invalid username/password"]
      render 'admin/login_form'
    end
  end

  def add_broker
    sucess = Broker.new(name: params[:name]).save!
  end

  def remove_broker
    render_404 unless broker = Broker.find(params[:id])
    broker.delete!
  end

  private
  def signup_params
    params.require(:admin).permit(:name, :email, :password, :password_confirmation)
  end

  def load_from_session
    @admin |=  Admin.find(session[:admin_id])
  end
end
