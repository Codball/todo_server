defmodule TodoServer.Todo.TodoList do
  use Ecto.Schema
  import Ecto.Changeset

  schema "todo_lists" do
    field :name, :string

    has_many :todo_items, TodoServer.Todo.TodoItem

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(todo_list, attrs) do
    todo_list
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
