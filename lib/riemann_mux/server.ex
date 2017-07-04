defmodule RiemannMux.Server do
  @behaviour :cowboy_handler

  def init(req0, state) do
    output = "hola"
    {:ok, req} = :cowboy_req.reply(200,
      %{"content-type" => "application/json"},
      output,
      req0)
    {:ok, req, state}
  end

  def terminate(_reason, _req, _state) do
    :ok
  end
end
