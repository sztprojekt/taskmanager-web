class GoogleCalendarService
  def initialize(user)
    @client = GoogleService.new(user).get_client
    @calendar = @client.discovered_api('calendar', 'v3')
  end

  def create_task(task)
    formatted = {
          'summary' => task.name,
          'description' => 'The description',
          'location' => 'Location',
          'start' => { 'dateTime' =>  Time.parse(task.created_at.to_s).utc.iso8601 },
          'end' => { 'dateTime' => Time.parse(task.due_date.to_s).utc.iso8601 }
    }

    result = @client.execute(:api_method => @calendar.events.insert,
                              :parameters => {'calendarId' => 'primary'},
                              :body => JSON.dump(formatted),
                              :headers => {'Content-Type' => 'application/json'})
    task.event_id = result.data.id
    task.sequence = 0
    task
  end
end