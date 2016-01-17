class Api::V1::RecipesController < Api::V1::BaseController
    
   def index
       @recipes = Recipe.limit(params[:limit]).offset(params[:offset])
       data = { recipes: @recipes }
       respond_with data
   end
   
end