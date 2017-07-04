defmodule RiemannMux.Ws do
  @behaviour :cowboy_websocket

  def init(req, state) do
    # IO.puts "Init: #{inspect req[:headers]}"
    # IO.puts "Path: #{inspect req[:path]}"
    # IO.puts "Qs: #{inspect req[:qs]}"
    spawn fn -> RiemannMux.spin("#{req[:path]}?#{req[:qs]}") end
    {:cowboy_websocket, req, state}
  end

  def websocket_init(state) do
    # IO.puts "Ws Init #{inspect state}"
    {:ok, state}
  end

  def websocket_handle(frame, state) do
    IO.puts "Received #{inspect frame}"
    {:ok, state}
  end
end
