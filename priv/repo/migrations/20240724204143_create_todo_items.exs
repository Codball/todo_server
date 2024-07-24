defmodule TodoServer.Repo.Migrations.CreateTodoItems do
  use Ecto.Migration

  def change do
    create table(:todo_items) do
      add :name, :string
      add :description, :string
      add :completed_at, :utc_datetime
      add :deleted_at, :utc_datetime
      add :todo_list_id, references(:todo_lists, on_delete: :nothing)

      timestamps(type: :utc_datetime)
    end

    create index(:todo_items, [:todo_list_id])
  end
end
