defmodule MemoryWeb.GamesChannel do
  alias Memory.State
  use GenServer


  def join("games:" <> game, payload, socket) do
    if authorized?(payload) do
      socket = assign(socket, :game, game)
      view = GameServer.view(game, socket.assigns[:user])
      {:ok, %{"join" => game, "game" => view}, socket}
    else
      {:error, %{reason: "unauthorized"}}
    end

  # Channels can be used in a request/response fashion
  # by sending replies to requests from the client
  def handle_in("ping", payload, socket) do
    {:reply, {:ok, payload}, socket}
  end

  # It is also common to receive messages from the client and
  # broadcast to everyone in the current topic (games:lobby).
  def handle_in("selectCard", %{"index" => ii}, socket) do
    view = GameServer.guess(socket.assigns[:game], socket.assigns[:user], ii)
    {:reply, {:ok, %{ "game" => view}}, socket}
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