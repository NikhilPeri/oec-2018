class BrokerController < ApplicationController
  before_action :load_from_session, except: %w(new create authenticate)

  def new
    @broker = Broker.new
  end

  def create
    @broker = Broker.new(signup_params)

    if @broker.save
        redirect_to '/broker'
    else
      render '/broker/new'
    end
  end

  def authenticate
    @broker = Broker.find_by_email(params[:broker][:email])

    if @broker && @broker.authenticate(params[:broker][:password])
      session[:broker_id] = @broker.id
      redirect_to '/broker'
    else
      @errors = ["invalid username/password"]
      render '/broker/login'
    end
  end

  private

  def signup_params
    params.require(:broker).permit(:name, :signup_key, :email, :password, :password_confirmation)
  end

  def load_from_session
    @broker ||= Broker.find(session[:broker_id]) unless session[:broker_id].nil?
    redirect_to '/broker/register' if @broker.nil?
  end
end
