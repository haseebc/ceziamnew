class ChecksController < ApplicationController
  skip_before_action :authenticate_user!, only: [:create, :show]

  def new
    @check = Check.new
  end

  def create
    # Run the check using the user input
     # Need to secure this action!!!
    # Create the check and store the JSON object
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

end