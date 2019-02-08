defmodule ElixirTrelloWeb.BoardView do
  use ElixirTrelloWeb, :view
  alias ElixirTrelloWeb.BoardView
  alias ElixirTrelloWeb.ListView

  def render("index.json", %{boards: boards}) do
    render_many(boards, BoardView, "board.json")
  end

  def render("show.json", %{board: board}) do
    render_one(board, BoardView, "board_with_lists.json")
  end

  def render("board.json", %{board: board}) do
    %{id: board.id, name: board.name}
  end

  def render("board_with_lists.json", %{board: board}) do
    %{id: board.id, name: board.name, lists: render_many(board.lists, ListView, "list.json")}
  end
end
