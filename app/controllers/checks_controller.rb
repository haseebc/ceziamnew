class ChecksController < ApplicationController

  skip_before_action :authenticate_user!, only: %i[create show]

  def new
    @check = Check.new
  end

  def create
    hostname_verified = hostname_valid?(params[:hostname])

    if hostname_verified
      @check = Check.new(hostname: hostname_verified)
      @check.user = current_user if current_user

      if @check.save
        if current_user
          redirect_to check_full_report_path(@check)
        else
          session[:last_check_id] = @check.id
          redirect_to check_path(@check)
        end
      else
        flash[:alert] = 'An error occured.'
        redirect_to root_path
      end
    else
      # feeback about non valid hostname
      flash[:alert] = 'Please remove "http://" or enter a valid hostname to run the check.'
      render 'pages/home'
    end
  end

  def show
    @check = Check.find(params[:id])
  end

  def full_report
    @check = Check.find(params[:check_id])
    unless @check.user
      @check.user = current_user
      @check.save
    end
  end

  private

  def hostname_param
    params.require(:check).permit(:hostname)
  end

  def hostname_valid?(user_input)
    valid_hostname_regex = /^(?!:\/\/)([a-zA-Z0-9-_]+\.)*[a-zA-Z0-9][a-zA-Z0-9-_]+\.[a-zA-Z]{2,11}?$/

    user_input.tr!('/', '') if user_input.end_with? '/'

    user_input.match(valid_hostname_regex)
  end

end
