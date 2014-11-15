class ApiController < ApplicationController

  skip_before_action :verify_authenticity_token
  before_filter :authenticate

  def authenticate
    if params[:controller] != "api" && params[:action] != "login"
      begin
        token = params.require :token
        user_hash = decode_login(token)
        @user = User.find_by_email user_hash["email"]
      rescue KeyError
        return die 'Missing token'
      rescue SecurityError => e
        return die e.message
      end
    end
  end

  def login
    begin
      email = params.require :email
      password = params.require :password
    rescue KeyError
      return die 'Missing or invalid parameters'
    end
    user = User.find_by_email email
    return die 'User not found' if user.nil?
    return die 'Invalid password' unless  user.valid_password? password
    succeed_with_data({token: encode_login({email: user.email})})
  end

  protected

  def die(message)
    render json: {message: message}, status: 400
  end

  def succeed_with_data(data)
    render json: {data: data}, status: 200
  end

  def success(message)
    render json: {message: message}, status: 200
  end

  def encode_login(hash)
    hash[:expires] = Time.now.to_i + 60*60*24*7;
    JWT.encode(hash, 'my secret string')
  end

  def decode_login(token)
    begin
      hash = JWT.decode(token, 'my secret string')
    rescue JWT::DecodeError
      raise SecurityError.new 'Missing or invalid token'
    end
    raise SecurityError.new 'Token expired' if hash[0]["expires"] <= Time.now.to_i
    raise SecurityError.new 'Token invalid' if hash[0]["email"].nil?
    hash[0]
  end

end
