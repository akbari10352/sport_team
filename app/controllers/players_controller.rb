class PlayersController < ApplicationController

  def create
    result = manage.add(player_params)
    render json: result[:body], status: result[:status]
  end

  def index
    result = manage.players
    render json: result[:body], status: result[:status]
  end

  def show
    result = manage.show(player_params[:uuid])
    render json: result[:body], status: result[:status]
  end

  def update
    result = manage.edit(player_params)
    render json: result[:body], status: result[:status]
  end

  def destroy
    result = manage.delete(player_params[:uuid])
    render json: result[:body], status: result[:status]
  end

  private

  def player_params
    params.permit(:name, :details, :uuid)
  end

  def manage
    manage = ::ManagePlayer.new(current_user)
  end

end
