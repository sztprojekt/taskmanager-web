class GoogleService
  def initialize(user)
    @client = Google::APIClient.new(application_name:    'Sample App AdamK',
                                        application_version: '1.0.0')
    @client.authorization.refresh_token = user.google_token
    @client.authorization.client_id = '13601182052-hdcr783ne4a9430vgutb7bpionpe6npn.apps.googleusercontent.com'
    @client.authorization.client_secret = 'G7-_znSUuPjXN-UORtKTwX-y'
    @client.authorization.scope = 'userinfo.email, userinfo.profile, https://www.googleapis.com/auth/calendar'
    if @client.authorization.access_token.nil?
      @client.authorization.grant_type = 'refresh_token'
      @client.authorization.fetch_access_token!
    end
  end

  def get_client
      @client
  end
end