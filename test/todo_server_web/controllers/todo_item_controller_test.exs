defmodule TodoServerWeb.TodoItemControllerTest do
  use TodoServerWeb.ConnCase

  import TodoServer.TodoFixtures

  alias TodoServer.Todo.TodoItem

  @create_attrs %{
    name: "some name",
    description: "some description",
    completed_at: ~U[2024-07-23 21:06:00Z],
    deleted_at: ~U[2024-07-23 21:06:00Z]
  }
  @update_attrs %{
    name: "some updated name",
    description: "some updated description",
    completed_at: ~U[2024-07-23 21:06:00Z],
    deleted_at: ~U[2024-07-23 21:06:00Z]
  }
  @invalid_attrs %{name: nil, description: nil, completed_at: nil, deleted_at: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all todo_items", %{conn: conn} do
      conn = get(conn, ~p"/api/todo_items")
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create todo_item" do
    test "renders todo_item when data is valid", %{conn: conn} do
      todo_list = todo_list_fixture()
      attrs = Map.put(@create_attrs, :todo_list_id, todo_list.id)
      conn = post(conn, ~p"/api/todo_items", todo_item: attrs)

      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, ~p"/api/todo_items/#{id}")

      assert %{
               "id" => ^id,
               "completed_at" => "2024-07-23T21:06:00Z",
               "deleted_at" => "2024-07-23T21:06:00Z",
               "description" => "some description",
               "name" => "some name"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/api/todo_items", todo_item: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update todo_item" do
    setup [:create_todo_item]

    test "renders todo_item when data is valid", %{conn: conn, todo_item: %TodoItem{id: id} = todo_item} do
      conn = put(conn, ~p"/api/todo_items/#{todo_item}", todo_item: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, ~p"/api/todo_items/#{id}")

      assert %{
               "id" => ^id,
               "completed_at" => "2024-07-23T21:06:00Z",
               "deleted_at" => "2024-07-23T21:06:00Z",
               "description" => "some updated description",
               "name" => "some updated name"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, todo_item: todo_item} do
      conn = put(conn, ~p"/api/todo_items/#{todo_item}", todo_item: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete todo_item" do
    setup [:create_todo_item]

    test "deletes chosen todo_item", %{conn: conn, todo_item: todo_item} do
      conn = delete(conn, ~p"/api/todo_items/#{todo_item}")
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, ~p"/api/todo_items/#{todo_item}")
      end
    end
  end

  defp create_todo_item(_) do
    todo_list = todo_list_fixture()
    todo_item = todo_item_fixture(%{todo_list_id: todo_list.id})

    %{todo_item: todo_item}
  end
end
