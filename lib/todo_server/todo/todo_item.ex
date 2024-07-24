defmodule TodoServer.Todo.TodoItem do
  use Ecto.Schema
  import Ecto.Changeset

  schema "todo_items" do
    field :name, :string
    field :description, :string
    field :completed_at, :utc_datetime
    field :deleted_at, :utc_datetime
    belongs_to :todo_list, TodoServer.Todo.TodoList

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(todo_item, attrs) do
    todo_item
    |> cast(attrs, [:name, :description, :completed_at, :deleted_at, :todo_list_id])
    |> validate_required([:name, :description, :todo_list_id])
  end
end
