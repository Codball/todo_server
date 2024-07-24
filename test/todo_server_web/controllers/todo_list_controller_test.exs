defmodule TodoServerWeb.TodoListControllerTest do
  use TodoServerWeb.ConnCase

  import TodoServer.TodoFixtures

  alias TodoServer.Todo.TodoList

  @create_attrs %{
    name: "some name"
  }
  @update_attrs %{
    name: "some updated name"
  }
  @invalid_attrs %{name: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all todo_lists", %{conn: conn} do
      conn = get(conn, ~p"/api/todo_lists")
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create todo_list" do
    test "renders todo_list when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/api/todo_lists", todo_list: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, ~p"/api/todo_lists/#{id}")

      assert %{
               "id" => ^id,
               "name" => "some name"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/api/todo_lists", todo_list: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update todo_list" do
    setup [:create_todo_list]

    test "renders todo_list when data is valid", %{conn: conn, todo_list: %TodoList{id: id} = todo_list} do
      conn = put(conn, ~p"/api/todo_lists/#{todo_list}", todo_list: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, ~p"/api/todo_lists/#{id}")

      assert %{
               "id" => ^id,
               "name" => "some updated name"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, todo_list: todo_list} do
      conn = put(conn, ~p"/api/todo_lists/#{todo_list}", todo_list: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete todo_list" do
    setup [:create_todo_list]

    test "deletes chosen todo_list", %{conn: conn, todo_list: todo_list} do
      conn = delete(conn, ~p"/api/todo_lists/#{todo_list}")
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, ~p"/api/todo_lists/#{todo_list}")
      end
    end
  end

  defp create_todo_list(_) do
    todo_list = todo_list_fixture()
    %{todo_list: todo_list}
  end
end
