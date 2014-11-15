##Mobile API Documentation

*Prefix every URL with `api`*

###Login
- URL: `/login`
- Method: `POST`
- Required Parameters: `email`, `password`
- Optional Parameters: None
- Returns: Authentication token.

###Get every task of current user
- URL: `/tasks`
- Method: `GET`
- Required Parameters: `token`
- Optional Parameters: None
- Returns: Every task of the user authenticated with the token.

###Get one task of current user
- URL: `/task`
- Method: `GET`
- Required Parameters: `token`, `id`
- Optional Parameters: None
- Returns: The requested task.

###Update the status of a task
- URL: `/task`
- Method: `PUT`
- Required Parameters: `token`, `id`, `status`
- Optional Parameters: None
- Returns: Sets a task's status to `status`.
- Notes: `status` should be either 1 or 0.
