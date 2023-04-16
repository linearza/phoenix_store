defmodule PhoenixStore.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      PhoenixStoreWeb.Telemetry,
      # Start the Ecto repository
      PhoenixStore.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: PhoenixStore.PubSub},
      # Start Finch
      {Finch, name: PhoenixStore.Finch},
      # Start the Endpoint (http/https)
      PhoenixStoreWeb.Endpoint
      # Start a worker by calling: PhoenixStore.Worker.start_link(arg)
      # {PhoenixStore.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: PhoenixStore.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    PhoenixStoreWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
