defmodule ElixirTrelloWeb.Router do
  use ElixirTrelloWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", ElixirTrelloWeb do
    pipe_through :api

    resources "/boards", BoardController do
      resources "/lists", ListController
    end
  end
end
