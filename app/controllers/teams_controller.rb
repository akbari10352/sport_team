class TeamsController < ApplicationController

  def show
    team = current_user.team
    render json: { name: team.name, description: team.description }
  end

  def update
    result = ::ManageTeam.new(current_user).edit(params.permit(:name, :description))
    render json: result[:body], status: result[:status]
  end

end
