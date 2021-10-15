class ManageMatch < Manage

  def show(uuid)
    return not_found unless (match = user.team.matches.find_by(uuid: uuid))

    response({ name: match.name, description: match.description, date: match.date })
  end

  def matches
    response(user.team.matches.as_json(only: %i[uuid name description date]))
  end

  def add(params)
    match = user.team.matches.new(
      name: params[:name],
      description: params[:description],
      date: params[:date],
      uuid: SecureRandom.uuid
    )
    return response({ success_message: 'match has been created successfully' }) if match.save

    response({ error_message: 'match creation has failes' }, :unprocessable_entity)
  end

  def edit(params)
    return not_found unless (match = user.team.matches.find_by(uuid: params[:uuid]))
    if match.update(name: params[:name], description: params[:description])
      return response({ success_message: 'match has been updated successfully' })
    end

    response({ error_message: 'match could not be updated' }, :unprocessable_entity)
  end

  def delete(uuid)
    return not_found unless (match = user.team.matches.find_by(uuid: uuid))
    return response({ success_message: 'match got deleted successfully' }) if match.destroy

    response({ error_message: 'match could not be deleted' }, :unprocessable_entity)
  end

  private

  def not_found
    response({ error_message: 'match not found' }, :not_found)
  end

end
