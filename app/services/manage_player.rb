class ManagePlayer < Manage

  def show(uuid)
    return not_found unless (player = user.team.players.find_by(uuid: uuid))

    response({ name: player.name, details: player.details })
  end

  def players
    response(user.team.players.as_json(only: %i[uuid name details]))
  end

  def add(params)
    player = user.team.players.new(
      name: params[:name],
      details: params[:details],
      uuid: SecureRandom.uuid
    )
    return response({ success_message: 'player has been created successfully' }) if player.save

    response({ error_message: 'player creation has failes' }, :unprocessable_entity)
  end

  def edit(params)
    return not_found unless (player = user.team.players.find_by(uuid: params[:uuid]))
    if player.update(name: params[:name], details: params[:details])
      return response({ success_message: 'player has been updated successfully' })
    end

    response({ error_message: 'player could not be updated' }, :unprocessable_entity)
  end

  def delete(uuid)
    return not_found unless (player = user.team.players.find_by(uuid: uuid))
    return response({ success_message: 'player got deleted successfully' }) if player.destroy

    response({ error_message: 'player could not be deleted' }, :unprocessable_entity)
  end

  private

  def not_found
    response({ error_message: 'player not found' }, :not_found)
  end

end
