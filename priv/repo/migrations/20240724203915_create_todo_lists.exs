defmodule TodoServer.Repo.Migrations.CreateTodoLists do
  use Ecto.Migration

  def change do
    create table(:todo_lists) do
      add :name, :string

      timestamps(type: :utc_datetime)
    end
  end
end
