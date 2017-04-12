class PagesController < ApplicationController
  include PublicIndex
  skip_before_action :authenticate_user!, only: [:about]

  def index
    @recipes = Recipe.order('created_at DESC').limit(4)
  end

  def about
  end

  def alltags
  	@alltags=ActsAsTaggableOn::Tag.all
  end  
end
