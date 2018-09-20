class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home, :glossary, :healthcheck]

  def home
  end

  def glossary
  end

  def healthcheck
  end

end
