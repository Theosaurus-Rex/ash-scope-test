defmodule ScopeResearchAndDevelopment.Books.Library do
  use Ash.Resource,
    otp_app: :scope_research_and_development,
    data_layer: AshPostgres.DataLayer,
    domain: ScopeResearchAndDevelopment.Books,
    authorizers: [Ash.Policy.Authorizer]

  postgres do
    table "libraries"
    repo ScopeResearchAndDevelopment.Repo
  end

  actions do
    defaults [:read, :destroy, update: :*, create: :*]
  end

  policies do
    policy always() do
      authorize_if always()
    end
  end

  attributes do
    uuid_primary_key :id

    attribute :name, :string do
      allow_nil? false
      public? true
    end

    attribute :address, :string do
      public? true
    end

    create_timestamp :created_at
    update_timestamp :updated_at
  end

  relationships do
    has_many :books, ScopeResearchAndDevelopment.Books.Book
  end
end
