class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home, :glossary]

  def home
  end

  def glossary
  end

end
