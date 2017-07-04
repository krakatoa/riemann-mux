defmodule RiemannMux do
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

  def spin do
    connect
    loop
  end

  def connect do
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
        loop
    end
  end
end
