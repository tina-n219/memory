defmodule MemoryWeb.GamesChannel do
  use MemoryWeb, :channel

  alias Memory.State
  alias Memory.GameServer

  def join("games:" <> game, payload, socket) do
    if authorized?(payload) do
      # Add user to players
      # If there are two players in the room, start the game
      socket = assign(socket, :game, game)
      view = GameServer.view(game, socket.assigns[:user])
      username = socket.assigns[:user]
      IO.inspect(username)
      #newPlayers = game.players ++ username
      newPlayers = []
      Map.put(game, :players, newPlayers)
      if (length(game.players) == 2) do
      {:ok, %{"join" => game, "game" => view}, socket}
      end
    else
      {:error, %{reason: "unauthorized"}}
    end
  end

  # It is also common to receive messages from the client and
  # broadcast to everyone in the current topic (games:lobby).
  def handle_in("selectCard", %{"index" => ii}, socket) do
    view = GameServer.guess(socket.assigns[:game], socket.assigns[:user], ii)
    broadcast(socket, "selectCard", view)
    {:reply, {:ok, %{ "game" => view}}, socket}
  end

  def handle_in("reset", payload, socket) do
    view = GameServer.reset(socket.assigns[:game], socket.assigns[:user])
    broadcast(socket, "reset", view)
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