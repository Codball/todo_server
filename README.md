# TodoServer

To start your Phoenix server:

  * Run `mix setup` to install and setup dependencies
  * Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`

# Functionality

  * Create a todo list;
    `POST localhost:4000/api/todo_lists`
    ```
    Body:
    {
      "todo_list": {
          "name": :string
      }
    }

    Response (201):
    {
      data: {
        id: :integer,
        name: :string,
        todo_items: []
      }
    }
    ```
  * Add a todo item;
    `POST localhost:4000/api/todo_items`
    ```
    Body:
    {
      "todo_list": {
          "name": :string,
          "description": :string,
      }
    }

    Response (201):
    {
      data: {
        id: :integer,
        name: :string,
        description: :string,
        completed_at: :utc_timestamp || :null,
        deleted_at: :utc_timestamp || :null,
      }
    }
    ```
  * View the items on the todo list;
    `GET localhost:4000/api/todo_lists/:id`
    ```
    Response (200):
    {
      data: {
        id: :integer,
        name: :string,
        todo_items: [{
          id: :integer,
          name: :string,
          description: :string,
          completed_at: :utc_timestamp || :null,
          deleted_at: :utc_timestamp || :null,
        }]
      }
    }
    ```
  * View all todo lists and their items;
    `GET localhost:4000/api/todo_lists`
    ```
    Response (200):
    {
      data: [{
        id: :integer,
        name: :string,
        todo_items: [{
          id: :integer,
          name: :string,
          description: :string,
          completed_at: :utc_timestamp || :null,
          deleted_at: :utc_timestamp || :null,
        }]
      }]
    }
    ```
  * Mark an item as done;
    `PATCH localhost:4000/api/todo_items/:id`
    ```
    Body:
    {
      "todo_item": {
        "completed_at": :utc_timestamp (ie "2024-07-25T00:00:00+00:00")
      }
    }

    Response (200):
    {
      data: {
        id: :integer,
        name: :string,
        description: :string,
        completed_at: :utc_timestamp,
        deleted_at: :utc_timestamp || :null,
      }
    }
    ```
  * Remove an item from the list;
    * Soft Delete:
    `PATCH localhost:4000/api/todo_items/:id`
      ```
      Body:
      {
        "todo_item": {
          "deleted_at": :utc_timestamp (ie "2024-07-25T00:00:00+00:00")
        }
      }

      Response (200):
      {
        data: {
          id: :integer,
          name: :string,
          description: :string,
          completed_at: :utc_timestamp || :null,
          deleted_at: :utc_timestamp,
        }
      }
      ```
    * Hard delete:
    `DELETE localhost:4000/api/todo_items/:id`
      ```
      Response (204) No Content
      ```
    
  * Possible Error Responses:
    * 404 Not Found
    * 422 Bad Data
    * 500 Server Error