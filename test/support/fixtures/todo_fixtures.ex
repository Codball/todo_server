defmodule TodoServer.TodoFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `TodoServer.Todo` context.
  """

  @doc """
  Generate a todo_list.
  """
  def todo_list_fixture(attrs \\ %{}) do
    {:ok, todo_list} =
      attrs
      |> Enum.into(%{
        name: "some name"
      })
      |> TodoServer.Todo.create_todo_list()

    todo_list
  end

  @doc """
  Generate a todo_item.
  """
  def todo_item_fixture(attrs \\ %{}) do
    {:ok, todo_item} =
      attrs
      |> Enum.into(%{
        completed_at: ~N[2024-07-23 20:41:00],
        deleted_at: ~N[2024-07-23 20:41:00],
        description: "some description",
        name: "some name"
      })
      |> TodoServer.Todo.create_todo_item()

    todo_item
  end
end
