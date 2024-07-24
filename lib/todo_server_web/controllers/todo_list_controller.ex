defmodule TodoServerWeb.TodoListController do
  use TodoServerWeb, :controller

  alias TodoServer.Todo
  alias TodoServer.Todo.TodoList

  action_fallback TodoServerWeb.FallbackController

  def index(conn, _params) do
    todo_lists = Todo.list_todo_lists()
    render(conn, :index, todo_lists: todo_lists)
  end

  def create(conn, %{"todo_list" => todo_list_params}) do
    with {:ok, %TodoList{} = todo_list} <- Todo.create_todo_list(todo_list_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/todo_lists/#{todo_list}")
      |> render(:show, todo_list: todo_list)
    end
  end

  def show(conn, %{"id" => id}) do
    todo_list = Todo.get_todo_list!(id)
    render(conn, :show, todo_list: todo_list)
  end

  def update(conn, %{"id" => id, "todo_list" => todo_list_params}) do
    todo_list = Todo.get_todo_list!(id)

    with {:ok, %TodoList{} = todo_list} <- Todo.update_todo_list(todo_list, todo_list_params) do
      render(conn, :show, todo_list: todo_list)
    end
  end

  def delete(conn, %{"id" => id}) do
    todo_list = Todo.get_todo_list!(id)

    with {:ok, %TodoList{}} <- Todo.delete_todo_list(todo_list) do
      send_resp(conn, :no_content, "")
    end
  end
end
