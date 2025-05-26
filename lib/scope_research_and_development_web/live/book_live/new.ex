defmodule ScopeResearchAndDevelopmentWeb.BookLive.New do
  use ScopeResearchAndDevelopmentWeb, :live_view

  def mount(_params, _session, socket) do
    form = ScopeResearchAndDevelopment.Books.form_to_create_book()

    socket =
      socket
      |> assign(:form, to_form(form))
      |> assign(:page_title, "Add New Book")

    {:ok, socket}
  end

  def render(assigns) do
    ~H"""
    <div class="max-w-2xl mx-auto">
      <.header>
        New Book
        <:subtitle>Create a new book record.</:subtitle>
      </.header>

      <.simple_form
        :let={form}
        id="book_form"
        as={:form}
        for={@form}
        phx-change="validate"
        phx-submit="save"
      >
        <div class="sm:flex gap-8 space-y-8 md:space-y-0">
          <div class="sm:w-3/4"><.input field={form[:title]} label="Title" /></div>
          <div class="sm:w-1/4">
            <.input field={form[:pages]} label="Number of Pages" type="number" />
          </div>
        </div>

        <:actions>
          <.button type="primary">Save</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  def handle_event("validate", %{"form" => form_data}, socket) do
    socket =
      update(socket, :form, fn form ->
        AshPhoenix.Form.validate(form, form_data)
      end)

    {:noreply, socket}
  end

  def handle_event("save", %{"form" => form_data}, socket) do
    case AshPhoenix.Form.submit(socket.assigns.form, params: form_data) do
      {:ok, _book} ->
        socket =
          socket
          |> put_flash(:info, "Book saved successfully")
          |> push_navigate(to: ~p"/")

        {:noreply, socket}

      {:error, form} ->
        socket =
          socket
          |> put_flash(:error, "Could not save book data")
          |> assign(:form, form)

        {:noreply, socket}
    end
  end
end
