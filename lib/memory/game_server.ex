# Code credit to Nat Tuck
# https://github.com/NatTuck/hangman/blob/multiplayer/lib/hangman/game_server.ex
defmodule Memory.GameServer do
  use GenServer

  alias Memory.State

  ## Client Interface
  def start_link(_args) do
    IO.puts "Link Started"
    GenServer.start_link(__MODULE__, %{}, name: __MODULE__)
  end

  def view(game, user) do
    IO.puts "View Requested"

    GenServer.call(__MODULE__, {:view, game, user})
  end

  def join_game(game, user) do
    GenServer.call(__MODULE__, {:joinGame, game, user})
  end

  def guess(game, user, cardIndex) do

    GenServer.call(__MODULE__, {:guess, game, user, cardIndex})
  end
  
  def restart(game, user) do
    GenServer.call(__MODULE__, {:restart, user})
  end

  ## Implementations
  def init(state) do
    IO.puts "State loop initialized"
    {:ok, state}
  end

  def handle_call({:view, game, user}, _from, state) do
    IO.puts "View Request made it to client"

    gg = Map.get(state, game, State.new)
    {:reply, State.client_view(gg, user), Map.put(state, game, gg)}
  end

  def handle_call({:joinGame, game user}, _from, state) do
    #State.join game
  end

  def handle_call({:guess, game, user, cardIndex}, _from, state) do
    gg = Map.get(state, game, State.new)
    |> State.guess(user, cardIndex)
    vv = State.client_view(gg, user)
    {:reply, vv, Map.put(state, game, gg)}
  end

  def handle_call({:reset, game, user}, _from, state) do
   # gg = Map.get(state, game, State.new)
    gg = State.new();
    {:reply, State.client_view(gg, user), Map.put(state, game, gg)}
  end
end