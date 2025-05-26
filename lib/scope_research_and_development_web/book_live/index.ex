defmodule ScopeResearchAndDevelopmentWeb.BookLive.Index do
  use ScopeResearchAndDevelopmentWeb, :live_view

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash}>
      <.header>
        Listing Books
        <:actions>
          <.button variant="primary" navigate={~p"/books/new"}>
            <.icon name="hero-plus" /> New Book
          </.button>
        </:actions>
      </.header>

      <.table
        id="books"
        rows={@streams.books}
        row_click={fn {_id, book} -> JS.navigate(~p"/books/#{book}") end}
      >
        <:col :let={{_id, book}} label="Id">{book.id}</:col>

        <:action :let={{_id, book}}>
          <div class="sr-only">
            <.link navigate={~p"/books/#{book}"}>Show</.link>
          </div>

          <.link navigate={~p"/books/#{book}/edit"}>Edit</.link>
        </:action>

        <:action :let={{id, book}}>
          <.link
            phx-click={JS.push("delete", value: %{id: book.id}) |> hide("##{id}")}
            data-confirm="Are you sure?"
          >
            Delete
          </.link>
        </:action>
      </.table>
    </Layouts.app>
    """
  end

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> stream(
       :books,
       Ash.read!(ScopeResearchAndDevelopment.Books.Book, scope: socket.assigns.current_scope)
     )
     |> assign_new(:current_user, fn -> nil end)}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Book")
    |> assign(
      :book,
      Ash.get!(ScopeResearchAndDevelopment.Books.Book, id, actor: socket.assigns.current_user)
    )
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Book")
    |> assign(:book, nil)
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Books")
    |> assign(:book, nil)
  end

  @impl true
  def handle_info({ScopeResearchAndDevelopmentWeb.BookLive.FormComponent, {:saved, book}}, socket) do
    {:noreply, stream_insert(socket, :books, book)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    book =
      Ash.get!(ScopeResearchAndDevelopment.Books.Book, id, actor: socket.assigns.current_user)

    Ash.destroy!(book, actor: socket.assigns.current_user)

    {:noreply, stream_delete(socket, :books, book)}
  end
end
