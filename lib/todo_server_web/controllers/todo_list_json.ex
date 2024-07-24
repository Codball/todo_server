defmodule TodoServerWeb.TodoListJSON do
  alias TodoServer.Todo.TodoList

  @doc """
  Renders a list of todo_lists.
  """
  def index(%{todo_lists: todo_lists}) do
    %{data: for(todo_list <- todo_lists, do: data(todo_list))}
  end

  @doc """
  Renders a single todo_list.
  """
  def show(%{todo_list: todo_list}) do
    %{data: data(todo_list)}
  end

  defp data(%TodoList{} = todo_list) do
    %{
      id: todo_list.id,
      name: todo_list.name
    }
  end
end
