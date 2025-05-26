defmodule ScopeResearchAndDevelopment.Books.Book do
  use Ash.Resource,
    otp_app: :scope_research_and_development,
    domain: ScopeResearchAndDevelopment.Books,
    data_layer: AshPostgres.DataLayer,
    authorizers: [Ash.Policy.Authorizer]

  postgres do
    table "books"
    repo ScopeResearchAndDevelopment.Repo
  end

  actions do
    defaults [:read, :destroy]

    create :create do
      accept [:title, :pages]
    end

    update :update do
      accept [:title, :pages]
    end
  end

  policies do
    policy action_type(:read) do
      authorize_if actor_present()
    end
  end

  multitenancy do
    strategy :attribute
    attribute :library_id
  end

  attributes do
    uuid_primary_key :id

    attribute :title, :string do
      allow_nil? false
    end

    attribute :pages, :integer do
      allow_nil? false
    end

    create_timestamp :inserted_at
    update_timestamp :updated_at
  end

  relationships do
    belongs_to :library, ScopeResearchAndDevelopment.Books.Library do
      allow_nil? true
    end
  end
end
