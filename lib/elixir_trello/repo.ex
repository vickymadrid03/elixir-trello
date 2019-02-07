defmodule ElixirTrello.Repo do
  use Ecto.Repo,
    otp_app: :elixir_trello,
    adapter: Ecto.Adapters.Postgres
end
