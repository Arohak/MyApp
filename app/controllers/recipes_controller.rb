class RecipesController < ApplicationController
  before_action :set_recipe, only: [:edit, :update, :show, :like]
  before_action :require_user, except: [:index, :show]
  before_action :require_same_user, only: [:edit, :update]
  
  def index
    # @recipes = Recipe.all.sort_by{|like| like.thumbs_up_total}.reverse
    @recipes = Recipe.paginate(page: params[:page], per_page: 3)
  end
  
  def show

  end
  
  def new
    @recipe = Recipe.new
  end
  
  def create
    @recipe = Recipe.new(recipe_params)
    @recipe.chef = current_user
    if @recipe.save 
      flash[:success] = "Your recipe was created succesfully"
      redirect_to recipes_path 
    else
      render :new
    end
  end
  
  def edit

  end
  
  def update
    if @recipe.update(recipe_params) 
      flash[:success] = "Your recipe updated succesfully"
      redirect_to recipe_path(@recipe)
    else
      render :edit
    end
  end
  
  def like 
    like = Like.create(like: params[:like], chef: current_user, recipe: @recipe)
    if like.valid?
      flash[:success] = "Your selection send succesfully"
      redirect_to :back
    else
      flash[:danger] = "You can only like/dislike a recipe once"
      redirect_to :back  
    end

  end
  
  private 
  
    def recipe_params
      params.require(:recipe).permit(:name, :summary, :description, :picture)
    end
    
    def set_recipe
      @recipe = Recipe.find(params[:id])
    end
    
    def require_same_user
      if current_user != @recipe.chef
        flash[:danger] = "You can only edit your own recipes"
        redirect_to root_path
      end
    end
end