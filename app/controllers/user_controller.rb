class UserController < ApplicationController
  def read
    respond_with_data ({user: {name: current_user.name}})
  end
end
