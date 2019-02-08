defmodule ElixirTrelloWeb.ListView do
  use ElixirTrelloWeb, :view
  alias ElixirTrelloWeb.ListView
  alias ElixirTrelloWeb.CardView

  def render("index.json", %{lists: lists}) do
    render_many(lists, ListView, "list.json")
  end

  def render("show.json", %{list: list}) do
    render_one(list, ListView, "list.json")
  end

  def render("list.json", %{list: list}) do
    %{id: list.id, name: list.name, cards: render_many(list.cards, CardView, "card.json")}
  end
end
