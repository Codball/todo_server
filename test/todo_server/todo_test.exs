defmodule TodoServer.TodoTest do
  use TodoServer.DataCase

  alias TodoServer.Todo

  describe "todo_lists" do
    alias TodoServer.Todo.TodoList

    import TodoServer.TodoFixtures

    @invalid_attrs %{name: nil}

    test "list_todo_lists/0 returns all todo_lists" do
      todo_list = todo_list_fixture()
      assert Todo.list_todo_lists() == [todo_list]
    end

    test "get_todo_list!/1 returns the todo_list with given id" do
      todo_list = todo_list_fixture()
      assert Todo.get_todo_list!(todo_list.id) == todo_list
    end

    test "create_todo_list/1 with valid data creates a todo_list" do
      valid_attrs = %{name: "some name"}

      assert {:ok, %TodoList{} = todo_list} = Todo.create_todo_list(valid_attrs)
      assert todo_list.name == "some name"
    end

    test "create_todo_list/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Todo.create_todo_list(@invalid_attrs)
    end

    test "update_todo_list/2 with valid data updates the todo_list" do
      todo_list = todo_list_fixture()
      update_attrs = %{name: "some updated name"}

      assert {:ok, %TodoList{} = todo_list} = Todo.update_todo_list(todo_list, update_attrs)
      assert todo_list.name == "some updated name"
    end

    test "update_todo_list/2 with invalid data returns error changeset" do
      todo_list = todo_list_fixture()
      assert {:error, %Ecto.Changeset{}} = Todo.update_todo_list(todo_list, @invalid_attrs)
      assert todo_list == Todo.get_todo_list!(todo_list.id)
    end

    test "delete_todo_list/1 deletes the todo_list" do
      todo_list = todo_list_fixture()
      assert {:ok, %TodoList{}} = Todo.delete_todo_list(todo_list)
      assert_raise Ecto.NoResultsError, fn -> Todo.get_todo_list!(todo_list.id) end
    end

    test "change_todo_list/1 returns a todo_list changeset" do
      todo_list = todo_list_fixture()
      assert %Ecto.Changeset{} = Todo.change_todo_list(todo_list)
    end
  end

  describe "todo_items" do
    alias TodoServer.Todo.TodoItem

    import TodoServer.TodoFixtures

    @invalid_attrs %{name: nil, description: nil, completed_at: nil, deleted_at: nil, todo_list_id: nil}

    setup do
      %{todo_list: todo_list_fixture()}
    end

    test "list_todo_items/0 returns all todo_items", %{todo_list: todo_list} do
      todo_item = todo_item_fixture(%{todo_list_id: todo_list.id})
      assert Todo.list_todo_items() == [todo_item]
    end

    test "get_todo_item!/1 returns the todo_item with given id", %{todo_list: todo_list} do
      todo_item = todo_item_fixture(%{todo_list_id: todo_list.id})
      assert Todo.get_todo_item!(todo_item.id) == todo_item
    end

    test "create_todo_item/1 with valid data creates a todo_item", %{todo_list: todo_list} do
      valid_attrs = %{name: "some name", description: "some description", completed_at: ~U[2024-07-24 20:41:00Z], deleted_at: ~U[2024-07-24 20:41:00Z], todo_list_id: todo_list.id}

      assert {:ok, %TodoItem{} = todo_item} = Todo.create_todo_item(valid_attrs)
      assert todo_item.name == "some name"
      assert todo_item.description == "some description"
      assert todo_item.completed_at == ~U[2024-07-24 20:41:00Z]
      assert todo_item.deleted_at == ~U[2024-07-24 20:41:00Z]
    end

    test "create_todo_item/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Todo.create_todo_item(@invalid_attrs)
    end

    test "update_todo_item/2 with valid data updates the todo_item", %{todo_list: todo_list} do
      todo_item = todo_item_fixture(%{todo_list_id: todo_list.id})
      update_attrs = %{name: "some updated name", description: "some updated description", completed_at: ~U[2024-07-24 20:41:00Z], deleted_at: ~U[2024-07-24 20:41:00Z]}

      assert {:ok, %TodoItem{} = todo_item} = Todo.update_todo_item(todo_item, update_attrs)
      assert todo_item.name == "some updated name"
      assert todo_item.description == "some updated description"
      assert todo_item.completed_at == ~U[2024-07-24 20:41:00Z]
      assert todo_item.deleted_at == ~U[2024-07-24 20:41:00Z]
    end

    test "update_todo_item/2 with invalid data returns error changeset", %{todo_list: todo_list} do
      todo_item = todo_item_fixture(%{todo_list_id: todo_list.id})
      assert {:error, %Ecto.Changeset{}} = Todo.update_todo_item(todo_item, @invalid_attrs)
      assert todo_item == Todo.get_todo_item!(todo_item.id)
    end

    test "delete_todo_item/1 deletes the todo_item", %{todo_list: todo_list} do
      todo_item = todo_item_fixture(%{todo_list_id: todo_list.id})
      assert {:ok, %TodoItem{}} = Todo.delete_todo_item(todo_item)
      assert_raise Ecto.NoResultsError, fn -> Todo.get_todo_item!(todo_item.id) end
    end

    test "change_todo_item/1 returns a todo_item changeset", %{todo_list: todo_list} do
      todo_item = todo_item_fixture(%{todo_list_id: todo_list.id})
      assert %Ecto.Changeset{} = Todo.change_todo_item(todo_item)
    end
  end
end
