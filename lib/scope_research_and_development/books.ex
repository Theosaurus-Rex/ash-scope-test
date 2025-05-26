defmodule ScopeResearchAndDevelopment.Books do
  use Ash.Domain,
    otp_app: :scope_research_and_development

  resources do
    resource ScopeResearchAndDevelopment.Books.Book do
      define :create_book, action: :create
      define :get_book_by_id, action: :read, get_by: :id
      define :update_book, action: :update
      define :destroy_book, action: :destroy
    end
  end
end
