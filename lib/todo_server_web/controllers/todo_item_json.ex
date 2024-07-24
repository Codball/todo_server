defmodule TodoServerWeb.TodoItemJSON do
  alias TodoServer.Todo.TodoItem

  @doc """
  Renders a list of todo_items.
  """
  def index(%{todo_items: todo_items}) do
    %{data: for(todo_item <- todo_items, do: data(todo_item))}
  end

  @doc """
  Renders a single todo_item.
  """
  def show(%{todo_item: todo_item}) do
    %{data: data(todo_item)}
  end

  def data(%TodoItem{} = todo_item) do
    %{
      id: todo_item.id,
      name: todo_item.name,
      description: todo_item.description,
      completed_at: todo_item.completed_at,
      deleted_at: todo_item.deleted_at
    }
  end
end
