defmodule TodoServerWeb.TodoListJSON do
  alias TodoServer.Todo.TodoList
  alias TodoServerWeb.TodoItemJSON

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

  def data(%TodoList{todo_items: todo_items} = todo_list) when is_list(todo_items) do
    %{
      id: todo_list.id,
      name: todo_list.name,
      todo_items: for(todo_item <- todo_list.todo_items, do: TodoItemJSON.data(todo_item))
    }
  end

  def data(%TodoList{} = todo_list) do
    %{
      id: todo_list.id,
      name: todo_list.name,
      todo_items: []
    }
  end
end
