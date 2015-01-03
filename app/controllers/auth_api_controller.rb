class AuthApiController < ApplicationController
  def google_auth
    client = Google::APIClient.new(application_name:    'Sample App AdamK',
                                    application_version: '1.0.0')
    client.authorization.client_id = '13601182052-hdcr783ne4a9430vgutb7bpionpe6npn.apps.googleusercontent.com'
    client.authorization.client_secret = 'G7-_znSUuPjXN-UORtKTwX-y'
    client.authorization.scope = 'userinfo.email, userinfo.profile, https://www.googleapis.com/auth/calendar'
    client.authorization.redirect_uri = 'http://localhost/google/'
    client.authorization.code = params[:code]
    client.authorization.refresh_token = '1/7_SkRlmUV1w85lKfMW0_Ck-4TQo2966XEZuRfIhqPPYMEudVrK5jSpoR30zcRFq6'
    token = client.authorization.fetch_access_token!

    plus = client.discovered_api('plus' , 'v1')

    result = client.execute(
        plus.people.get,
        {'userId' => 'me'}
    )
    result_data = result.data
    google_user_id = result_data['id']
    user = User.find_by_google_id google_user_id
    if user.nil?
      user = User.new
      user.google_id = result_data['id']
      user.role_id = 1
      user.name = result_data['displayName']
      user.email = result_data['emails'].first['value']
      user.google_token = token['refresh_token']
      user.password = "janos1242141221124"
      user.save
    end

    render json: {data: {token: encode_login({email: user.email})}}
  end

  def encode_login(hash)
    hash[:expires] = Time.now.to_i + 60*60*24*7;
    JWT.encode(hash, 'my secret string')
  end
end