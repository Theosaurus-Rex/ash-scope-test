defmodule ScopeResearchAndDevelopment.Books do
  use Ash.Domain,
    otp_app: :scope_research_and_development,
    extensions: [AshPhoenix, Ash.Policy.Authorizer]

  resources do
    resource ScopeResearchAndDevelopment.Books.Book do
      define :create_book, action: :create
      define :get_book_by_id, action: :read, get_by: :id
      define :list_books, action: :read
      define :update_book, action: :update
      define :destroy_book, action: :destroy
    end

    resource ScopeResearchAndDevelopment.Books.Library do
      define :get_library_by_id,
        action: :read,
        get_by: :id

      define :list_libraries, action: :read
      define :create_library, action: :create
      define :update_library, action: :update

      define :destroy_library,
        action: :destroy
    end
  end

  authorization do
    authorize :always
  end
end
