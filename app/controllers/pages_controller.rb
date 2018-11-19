class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home, :glossary, :healthcheck, :privacy, :blog, :about]

  def home
  end

  def glossary
  end

  def healthcheck
  end

  def privacy
  end

  def blog
  end

  def about
  end
end
