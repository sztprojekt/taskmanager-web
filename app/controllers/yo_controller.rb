class YoController < ApplicationController
  def google
    client = Google::APIClient.new(application_name:    'Sample App AdamK',
                                   application_version: '1.0.0')
    client.authorization.client_id = '13601182052-hdcr783ne4a9430vgutb7bpionpe6npn.apps.googleusercontent.com'
    client.authorization.client_secret = 'G7-_znSUuPjXN-UORtKTwX-y'
    client.authorization.access_token = 'ya29.3QD4eEIF4Osf2IxsT6xV49sQJbeFdQTLAM6SnNV0a_Mdi26BoBayr7ZfXsJILk_xxP7MiFRUn5iz6Q'
    client.authorization.scope = 'userinfo.email, userinfo.profile, https://www.googleapis.com/auth/calendar'
    service = client.discovered_api('calendar', 'v3')
    @result = client.execute(
            :api_method => service.calendar_list.list,
            :parameters => {},
            :headers => {'Content-Type' => 'application/json'})
    puts "YYOYOYOYOOOOOOOOOOOOOOOOOOOOOOOOOOOOOo"
    p @result

    render template: "yo/google"
    # render json: result
  end

  def shiz
    auth = request.env["omniauth.auth"]
    user = User.new
    user.name = auth[:info][:name]
    user.email = auth[:info][:email]
    user.google_token = auth[:credentials][:refresh_token]
    user.google_id = auth[:uid]
    user.password = "yoyoyoyoy"
    user.role_id = 1

    user.save
    render json: [auth, user, user.errors]
  end

  def calendar
    user = User.find 12

    google_calendar_service = GoogleCalendarService.new user
    task = Task.find 19

    result = google_calendar_service.create_task task
    task.save
    # client.discovered_api 'oauth2', 'v2'
    # result = client.execute(
    #     :api_method => service.calendar_list.list,
    #     :parameters => {},
    #     :headers => {'Content-Type' => 'application/json'})
    # puts "YYOYOYOYOOOOOOOOOOOOOOOOOOOOOOOOOOOOOo"
    # puts ""
    # p result.response
    # result_event = client.execute(:api_method => service.events.list,
    #                         :parameters => {'calendarId' => 'primary'})

    # render json: [result_event.data.items]
    # render json: [result.response]
    # render json: [result_event.response]
    render json: task
    # render template: "yo/google"
  end
end

# client = Google::APIClient.new(application_name:    'Sample App AdamK',
#                                application_version: '1.0.0')
#
# client.authorization.refresh_token = user.google_token
# client.authorization.client_id = '13601182052-hdcr783ne4a9430vgutb7bpionpe6npn.apps.googleusercontent.com'
# client.authorization.client_secret = 'G7-_znSUuPjXN-UORtKTwX-y'
# # client.authorization.access_token = 'ya29.3QD4eEIF4Osf2IxsT6xV49sQJbeFdQTLAM6SnNV0a_Mdi26BoBayr7ZfXsJILk_xxP7MiFRUn5iz6Q'
# client.authorization.scope = 'userinfo.email, userinfo.profile, https://www.googleapis.com/auth/calendar'
# client.authorization.grant_type = 'refresh_token'
# client.authorization.fetch_access_token!
# client.discovered_apis.each do |gapi|
#   puts "#{gapi.title} \t #{gapi.id} \t #{gapi.preferred}"
# end