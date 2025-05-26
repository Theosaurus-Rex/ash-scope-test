defmodule ScopeResearchAndDevelopment.Accounts.Scope do
  @moduledoc """
  Defines the scope of the caller to be used throughout the app.

  The `ScopeResearchAndDevelopment.Accounts.Scope` implements the `Ash.Scope` protocol
  to provide standardized access to actor (user), tenant, and context information.
  This allows for consistent usage across the application and integration with
  Ash's authorization and context systems.
  """

  alias ScopeResearchAndDevelopment.Accounts.User

  defstruct [:user, :tenant, :context]

  @doc """
  Creates a scope for the given user.

  Returns nil if no user is given.
  """
  def for_user(%User{} = user) do
    %__MODULE__{user: user, context: %{}}
  end

  def for_user(nil), do: nil

  @doc """
  Creates a scope with all available options.
  """
  def new(user \\ nil, tenant \\ nil, context \\ %{}) do
    %__MODULE__{
      user: user,
      tenant: tenant,
      context: context
    }
  end
end

defimpl Ash.Scope, for: ScopeResearchAndDevelopment.Accounts.Scope do
  def get_actor(%{user: user}), do: {:ok, user}
  def get_tenant(%{tenant: tenant}), do: {:ok, tenant}
  def get_context(%{context: context}), do: {:ok, context || %{}}
end
