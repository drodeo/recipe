class RecipesController < ApplicationController
  include PublicIndex
  #load_and_authorize_resource
  before_action :find_recipe, only: [:show, :edit, :destroy, :update]
  before_action :build_comment, only: :show
  skip_before_action :authenticate_user!, only: [:index, :show]
  
  def index
     if params[:tag]
       @recipes = Recipe.tagged_with(params[:tag]).page(params[:page]).per(10)
     else
       @recipes = Recipe.order('created_at DESC').page(params[:page]).per(10)
       @loves = Recipe.order('created_at DESC').page(params[:page]).per(10)
     end
  end

  def new
    @recipe = Recipe.new
     respond_with(@purchase = Purchase.new)
  end

  def edit
  end
  
  def addtolove
    @recipe = Recipe.find(params[:format])
    @recipe.love_id=current_user.id
    @recipe.save
    redirect_to recipes_path
  end

  def destroy
    @recipe.destroy
    redirect_to recipes_path
  end

  def create
    @recipe = Recipe.new(recipe_params)
    @recipe.owner_id = current_user.id
    #upload=Cloudinary::Uploader.upload(purchase_params[:image]) unless purchase_params[:image].blank?
    #@purchase.image_file_name=upload['url'] unless purchase_params[:image].blank?
    #@recipe.image.save
  
    if @recipe.save
      #lo
      redirect_to recipes_path
    else
      
      render 'new'
    end 
  end

  def update
    if @recipe.update(recipe_params)
      redirect_to recipe_path(@recipe)
    else
      redirect_to edit_recipe_path(@recipe)
    end
  end

  def show
    @recipe       = Recipe.find(params[:id])
    
  end

  

  private

  def find_recipe
    @recipe = Recipe.find(params[:id])
  end

  def recipe_params
    params.require(:recipe).permit(:name, :description, :image, :short, :tag_list)
  end

  def build_comment
    @new_comment = Comment.build_from(@recipe, current_user, '')
  end
end
