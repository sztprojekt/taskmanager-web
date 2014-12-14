class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  after_filter :set_csrf_cookie_for_ng
  skip_before_filter :verify_authenticity_token

  def set_csrf_cookie_for_ng
    cookies['XSRF-TOKEN'] = form_authenticity_token if protect_against_forgery?
  end

  protected

  def verified_request?
    super || form_authenticity_token == request.headers['X-XSRF-TOKEN']
  end

  def respond_with_data(data)
    render json: {data: data}, status: 200
  end

  def success(message)
    render json: {message: message}, status: 200
  end

  def die(message)
    render json: {message: message}, status: 400
  end

end
