class MatchesController < ApplicationController

  def create
    result = manage.add(match_params)
    render json: result[:body], status: result[:status]
  end

  def index
    result = manage.matches
    render json: result[:body], status: result[:status]
  end

  def show
    result = manage.show(match_params[:uuid])
    render json: result[:body], status: result[:status]
  end

  def update
    result = manage.edit(match_params)
    render json: result[:body], status: result[:status]
  end

  def destroy
    result = manage.delete(match_params[:uuid])
    render json: result[:body], status: result[:status]
  end

  private

  def match_params
    params.permit(:name, :description, :uuid, :date)
  end

  def manage
    ::ManageMatch.new(current_user)
  end

end
