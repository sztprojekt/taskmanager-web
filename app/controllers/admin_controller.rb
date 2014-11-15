class AdminController < ApplicationController
  layout 'admin'

  def index
    @site_url = Rails.application.config.site_url
  end
end
