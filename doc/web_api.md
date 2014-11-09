##Web API Documentation

###Get every task of the current user
- URL: `/tasks`
- Method: `GET`
- Returns: Every task of the user.

###Create a new task for the current user
- URL: `/task`
- Method: `POST`
- Required Parameters: `name`, `due_date`
- Returns: The newly created task.

###Get a task for the current user
- URL: `/task`
- Method: `GET`
- Required Parameters: `id`
- Returns: The requested task.

###Update a task of the current user
- URL: `/task`
- Method: `PUT`
- Required Parameters: `id`, `name`, `due_date`
- Returns: Success message.

###Delete a task of the current user
- URL: `/task`
- Method: `DELETE`
- Required Parameters: `id`
- Returns: Success message.

