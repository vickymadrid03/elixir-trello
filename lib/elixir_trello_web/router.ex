defmodule ElixirTrelloWeb.Router do
  use ElixirTrelloWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", ElixirTrelloWeb do
    pipe_through :api
  end
end
