# Code credit to Nat Tuck
# https://github.com/NatTuck/hangman/blob/multiplayer/lib/hangman/game_server.ex

defmodule Memory.GameServer do
  use GenServer

  alias Memory.State

  ## Client Interface
  def start_link(_args) do
    GenServer.start_link(__MODULE__, %{}, name: __MODULE__)
  end

  def view(game, user) do
    GenServer.call(__MODULE__, {:view, game, user})
  end

  def guess(game, user, letter) do
    GenServer.call(__MODULE__, {:guess, game, user, letter})
  end

  ## Implementations
  def init(state) do
    {:ok, state}
  end

  def handle_call({:view, game, user}, _from, state) do
    gg = Map.get(state, game, State.new)
    {:reply, State.client_view(gg, user), Map.put(state, game, gg)}
  end

  def handle_call({:guess, game, user, letter}, _from, state) do
    gg = Map.get(state, game, State.new)
    |> State.guess(user, letter)
    vv = State.client_view(gg, user)
    {:reply, vv, Map.put(state, game, gg)}
  end
end