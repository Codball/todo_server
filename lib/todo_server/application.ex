defmodule TodoServer.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      TodoServerWeb.Telemetry,
      TodoServer.Repo,
      {DNSCluster, query: Application.get_env(:todo_server, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: TodoServer.PubSub},
      # Start a worker by calling: TodoServer.Worker.start_link(arg)
      # {TodoServer.Worker, arg},
      # Start to serve requests, typically the last entry
      TodoServerWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: TodoServer.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    TodoServerWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
