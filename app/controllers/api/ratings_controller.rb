class Api::RatingsController < Api::BaseController
  before_action :doorkeeper_authorize!
  before_action :current_user_authenticate

  def index
    recipe = Recipe.find(params[:recipe_id])
    @ratings = recipe.ratings.includes(:user)
  end

  def create
    recipe = Recipe.find(params[:recipe_id])

    @rating = recipe.ratings.new(
      score: params[:score],
      comment: params[:comment],
      user: current_user
    )

    @error_messages = @rating.errors.messages unless @rating.save
  end

  def update
    @rating = current_user.ratings.find(params[:id])

    @rating.assign_attributes(
      score: params[:score] || @rating.score,
      comment: params[:comment] || @rating.comment
    )

    @error_messages = @rating.errors.messages unless @rating.save
  end

  def show
    @rating = Rating.find(params[:id])
  end

  def destroy
    rating = current_user.ratings.find(params[:id])
    rating.destroy
  end
end
