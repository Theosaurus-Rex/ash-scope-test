defmodule ScopeResearchAndDevelopment.Books.Book do
  use Ash.Resource,
    otp_app: :scope_research_and_development,
    domain: ScopeResearchAndDevelopment.Books,
    data_layer: AshPostgres.DataLayer

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
end
