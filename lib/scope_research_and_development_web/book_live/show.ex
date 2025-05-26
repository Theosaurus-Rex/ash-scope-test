defmodule ScopeResearchAndDevelopmentWeb.BookLive.Show do
  use ScopeResearchAndDevelopmentWeb, :live_view

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash}>
      <.header>
        Book {@book.id}
        <:subtitle>This is a book record from your database.</:subtitle>

        <:actions>
          <.button navigate={~p"/books"}>
            <.icon name="hero-arrow-left" />
          </.button>
          <.button variant="primary" navigate={~p"/books/#{@book}/edit?return_to=show"}>
            <.icon name="hero-pencil-square" /> Edit Book
          </.button>
        </:actions>
      </.header>

      <.list>
        <:item title="Id">{@book.id}</:item>
      </.list>
    </Layouts.app>
    """
  end

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(
       :book,
       Ash.get!(ScopeResearchAndDevelopment.Books.Book, id, actor: socket.assigns.current_user)
     )}
  end

  defp page_title(:show), do: "Show Book"
  defp page_title(:edit), do: "Edit Book"
end
