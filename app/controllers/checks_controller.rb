class ChecksController < ApplicationController
  skip_before_action :authenticate_user!, only: [:create, :show]

  def new
    @check = Check.new
  end

  def create
    if hostname_valid?(params[:hostname]).nil?
      # feeback about non valid hostname
      flash[:notice] = "Please remove \"http://\" or enter a valid hostname to run the check."
      render 'pages/home'

    else

      @check = CheckService.new(params[:hostname]).run

      if current_user 
        @check.user = current_user
          if @check.save
            redirect_to check_full_report_path(@check)
          else
            redirect_to root_path
          end
      else 
          if @check.save
            session[:last_check_id] = @check.id
            redirect_to check_path(@check)
          else
            redirect_to root_path
          end
      end 
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

    if user_input.end_with? "/"
      user_input.tr!("/", "")
    end

    user_input.match(valid_hostname_regex)
  end
end
