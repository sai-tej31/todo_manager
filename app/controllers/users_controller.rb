class UsersController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    render plain: User.order(:id).map { |user| user.to_pleasant_string }.join("\n")
  end

  def create
    name = params[:name]
    email = params[:email]
    password = params[:password]
    newuser = User.create(
      name: name,
      email: email,
      password: password,
    )
    render plain: "new user created with #{newuser.id}"
  end

  def login
    user = User.where("email=? and password=?", params[:email], params[:password])
    render plain: (user.length == 0) ? "False" : "True"
  end
end
