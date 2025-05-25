defmodule ScopeResearchAndDevelopment.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      ScopeResearchAndDevelopmentWeb.Telemetry,
      ScopeResearchAndDevelopment.Repo,
      {DNSCluster, query: Application.get_env(:scope_research_and_development, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: ScopeResearchAndDevelopment.PubSub},
      # Start a worker by calling: ScopeResearchAndDevelopment.Worker.start_link(arg)
      # {ScopeResearchAndDevelopment.Worker, arg},
      # Start to serve requests, typically the last entry
      ScopeResearchAndDevelopmentWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: ScopeResearchAndDevelopment.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    ScopeResearchAndDevelopmentWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
