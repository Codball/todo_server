defmodule TodoServerWeb.Router do
  use TodoServerWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", TodoServerWeb do
    pipe_through :api

    resources "/todo_lists", TodoListController, except: [:new, :edit]
    resources "/todo_items", TodoItemController, except: [:new, :edit]
  end
end
