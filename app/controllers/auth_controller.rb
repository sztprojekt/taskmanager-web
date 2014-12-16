class AuthController < ApplicationController
  def google_auth
    auth = request.env["omniauth.auth"]
    google_id = auth[:uid]
    user = User.find_by_google_id google_id

    if user.nil?
      user = User.new
      user.name = auth[:info][:name]
      user.email = auth[:info][:email]
      user.google_token = auth[:credentials][:refresh_token]
      user.google_id = auth[:uid]
      user.password = "yoyoyoyoy"
      user.role_id = 1
      user.save
    end

    uri = URI.parse(request.url)

    sign_in(:user, user)
    redirect_to "http://localhost:3000/"
  end
end