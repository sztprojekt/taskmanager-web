class ApiController < ApplicationController

  skip_before_action :verify_authenticity_token

  def login
    begin
      email = params.require :email
      password = params.require :password
    rescue KeyError
      return die 'missing or invalid parameters'
    end
    user = User.find_by_email email
    return die 'user not found' if user.nil?
    return die 'invalid password' unless  user.valid_password? password
    succeed_with_data({token: encode_login({email: user.email})})
  end

  protected

  def die(message)
    render json: message, status: 400
  end

  def succeed_with_data(data)
    render json: {data: data}, status: 200
  end

  def encode_login(hash)
    hash[:expires] = Time.now.to_i + 60*60*24*7;
    JWT.encode(hash, 'my secret string')
  end

  def decode_login(token)
    begin
      hash = JWT.decode(token, 'my secret string')
    rescue JWT::DecodeError
      die 'missing or invalid token'
    end
    die 'token expired' if hash[0]["expires"] <= Time.now.to_i
    die 'token invalid' if hash[0]["email"].nil?
    hash[0]
  end

end
