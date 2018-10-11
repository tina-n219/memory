defmodule MemoryWeb.GamesChannel do
  use MemoryWeb, :channel

  alias Memory.State
  alias Memory.GameServer

  def join("games:" <> game, payload, socket) do
    if authorized?(payload) do
      socket = assign(socket, :game, game)
      view = GameServer.view(game, socket.assigns[:user])
      {:ok, %{"join" => game, "game" => view}, socket}
    else
      {:error, %{reason: "unauthorized"}}
    end
  end

  # It is also common to receive messages from the client and
  # broadcast to everyone in the current topic (games:lobby).
  def handle_in("selectCard", %{"index" => ii}, socket) do
    view = GameServer.guess(socket.assigns[:game], socket.assigns[:user], ii)
    broadcast(socket, "update", view)
    {:reply, {:ok, %{ "game" => view}}, socket}
  end

  def handle_in("reset", payload, socket) do
    view = GameServer.reset(socket.assigns[:game], socket.assigns[:user])
    broadcast(socket, "update", view)
    {:reply, {:ok, %{ "game" => view}}, socket}
  end

  def handle_in("join_game", _, socket) do
    IO.puts"Games Channel join_Game"
    view = GameServer.join_game(socket.assigns[:game], socket.assigns[:user])
    broadcast(socket, "update", view)
    #{:reply, {:ok, %{ "game" => view}}, socket}
    {:noreply, socket}
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