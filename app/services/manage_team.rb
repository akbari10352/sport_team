class ManageTeam < Manage

  def show
    response({ name: user.team.name, description: user.team.description })
  end

  def edit(params)
    team = user.team
    if team.update(name: params[:name], description: params[:description])
      return response({ success_message: 'team updated succssfully' })
    end

    response({ error_message: 'team update has failed' }, :unprocessable_entity)
  end

end
