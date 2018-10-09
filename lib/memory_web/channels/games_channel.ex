defmodule MemoryWeb.GamesChannel do
  use MemoryWeb, :channel

  alias Memory.State
  alias Memory.BackupAgent

  def join("games:" <> name, payload, socket) do
    if authorized?(payload) do
      game = State.new()
      socket = socket
      |> assign(:game, game)
      |> assign(:name, name)
      {:ok, %{"join" => name, "game" => State.client_view(game)}, socket}
    else
      {:error, %{reason: "unauthorized"}}
    end
  end

  # Channels can be used in a request/response fashion
  # by sending replies to requests from the client
  def handle_in("ping", payload, socket) do
    {:reply, {:ok, payload}, socket}
  end

  # It is also common to receive messages from the client and
  # broadcast to everyone in the current topic (games:lobby).
  def handle_in("selectCard", %{"index" => ii}, socket) do
    game = State.guess(socket.assigns[:game], ii)
    socket = assign(socket, :game, game)
    {:reply, {:ok, %{ "game" => State.client_view(game)}}, socket}
  end

  # def handle_in("restart", payload, socket) do
  #   game = State.new()
  #   socket = assign(socket, :game, game)
  #   BackupAgent.put(socket.assigns[:name], game)
  #   {:reply, {:ok, %{"game" => State.client_view(game)}}, socket}
  # end

  # Add authorization logic here as required.
  defp authorized?(_payload) do
    true
  end
end
