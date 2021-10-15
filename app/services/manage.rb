class Manage

  attr_accessor :user

  def initialize(user)
    @user = user
  end

  def response(body, status = :ok)
    { body: body, status: status }
  end

end
