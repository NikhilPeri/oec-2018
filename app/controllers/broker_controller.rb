class BrokerController < ApplicationController
  before_action :load_broker, only: :show

  def new
    @broker = Broker.new
  end

  def create
    @broker = Broker.new(signup_params)

    if @broker.save
        session[:broker_id] = @broker.id
        redirect_to '/broker'
    else
      render '/broker/new'
    end
  end

  def authenticate
    @broker = Admin.find_by_email(params[:broker][:email])

    if @broker && @broker.authenticate(params[:broker][:password])
      session[:broker] = @broker.id
      redirect_to '/broker'
    else
      @errors = ["invalid username/password"]
      render 'broker/login'
    end
  end

  private

  def signup_params
    params.require(:broker).permit(:name, :signup_key, :email, :password, :password_confirmation)
  end

  def load_broker
    @broker ||= Broker.find(token: params[:token])
  end
end
