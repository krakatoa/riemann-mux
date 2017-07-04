defmodule RiemannMux do
  use Application

  def start(_type, _args) do
    dispatch = :cowboy_router.compile([
      {:'_', [
        {'/test', RiemannMux.Server, []},
        {'/index', RiemannMux.Ws, []}
      ]}
    ])
    # :cowboy.start_http :http_listener, 100, [{:port, 8081}],
    :cowboy.start_clear :http_listener, [{:port, 8081}],
      %{:env => %{:dispatch => dispatch}}
    RiemannMux.Supervisor.start_link
  end

  @moduledoc """
  Documentation for RiemannMux.
  """

  @doc """
  Hello world.

  ## Examples

      iex> RiemannMux.hello
      :world

  """
  def hello do
    :world
  end

  def spin(path) do
    connect(path)
    loop()
  end

  def connect(path) do
    {:ok, pid} = :gun.open('127.0.0.1', 5556, %{:retry => 0})
    {:ok, :http} = :gun.await_up(pid)
    :gun.ws_upgrade(pid, "/index?subscribe=true&query=true", [], %{:compress => true})
    receive do
      {:gun_ws_upgrade, pid, :ok, _headers} -> :ok
    end
  end

  def loop do
    receive do
      {:gun_ws, pid, frame} ->
        IO.puts(inspect frame)
        loop()
    end
  end
end
