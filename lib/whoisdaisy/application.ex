defmodule Whoisdaisy.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      WhoisdaisyWeb.Telemetry,
      {DNSCluster, query: Application.get_env(:whoisdaisy, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: Whoisdaisy.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: Whoisdaisy.Finch},
      # Start a worker by calling: Whoisdaisy.Worker.start_link(arg)
      # {Whoisdaisy.Worker, arg},
      # Start to serve requests, typically the last entry
      WhoisdaisyWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Whoisdaisy.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    WhoisdaisyWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
