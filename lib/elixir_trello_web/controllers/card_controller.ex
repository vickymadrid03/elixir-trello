defmodule ElixirTrelloWeb.CardController do
  use ElixirTrelloWeb, :controller

  alias ElixirTrello.Cards
  alias ElixirTrello.Cards.Card

  action_fallback ElixirTrelloWeb.FallbackController

  def index(conn, _params) do
    cards = Cards.list_cards()
    render(conn, "index.json", cards: cards)
  end

  def create(conn, %{"card" => card_params, "list_id" => list_id, "board_id" => board_id}) do
    {list_id, _} = Integer.parse(list_id)

    with {:ok, %Card{} = card} <- Cards.create_card(list_id, card_params) do
      conn
      |> put_status(:created)
      |> put_resp_header(
        "location",
        Routes.board_list_card_path(conn, :show, board_id, list_id, card)
      )
      |> render("show.json", card: card)
    end
  end

  def show(conn, %{"id" => id}) do
    card = Cards.get_card!(id)
    render(conn, "show.json", card: card)
  end

  def update(conn, %{"id" => id, "card" => card_params}) do
    card = Cards.get_card!(id)

    with {:ok, %Card{} = card} <- Cards.update_card(card, card_params) do
      render(conn, "show.json", card: card)
    end
  end

  def delete(conn, %{"id" => id}) do
    card = Cards.get_card!(id)

    with {:ok, %Card{}} <- Cards.delete_card(card) do
      send_resp(conn, :no_content, "")
    end
  end
end
