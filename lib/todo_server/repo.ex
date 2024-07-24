defmodule TodoServer.Repo do
  use Ecto.Repo,
    otp_app: :todo_server,
    adapter: Ecto.Adapters.Postgres
end
