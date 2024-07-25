# TodoServer

To start your Phoenix server:

  * Run `mix setup` to install and setup dependencies
  * Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](https://hexdocs.pm/phoenix/deployment.html).

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

    Response (200):
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

    Response (200):
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
    Response:
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
  * Mark an item as done;
    `PATCH localhost:4000/api/todo_items/:id`
    ```
    Body:
    {
      "todo_item": {
        "completed_at": :utc_timestamp ("2024-07-25T00:00:00+00:00")
      }
    }
    ```
  * Remove an item from the list;
    Soft Delete:
    `PATCH localhost:4000/api/todo_items/:id`
    ```
    Body:
    {
      "todo_item": {
        "deleted_at": :utc_timestamp ("2024-07-25T00:00:00+00:00")
      }
    }
    ```
    Hard delete:
    `DELETE localhost:4000/api/todo_items/:id`
