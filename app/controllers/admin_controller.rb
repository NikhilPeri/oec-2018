class AdminController < ApplicationController
  before_action :authenticate

  def new
    @admin = Admin.new
  end

  def create
    @admin = Admin.new(signup_params)

    if @admin.save
        session[:admin_id] = @admin.id
        redirect_to '/admin'
    else
      redirect_to '/admin/configure'
    end
  end

  def show

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

  def authenticate
    render 'login' unless true #replace with actual authentication
  end
end
