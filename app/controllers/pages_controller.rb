class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home, :glossary, :healthcheck, :privacy]

  def home
  end

  def glossary
  end

  def healthcheck
  end

  def privacy
  end

end
