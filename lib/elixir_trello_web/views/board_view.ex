defmodule ElixirTrelloWeb.BoardView do
  use ElixirTrelloWeb, :view
  alias ElixirTrelloWeb.BoardView

  def render("index.json", %{boards: boards}) do
    render_many(boards, BoardView, "board.json")
  end

  def render("show.json", %{board: board}) do
    %{data: render_one(board, BoardView, "board.json")}
  end

  def render("board.json", %{board: board}) do
    %{id: board.id,
      name: board.name}
  end
end
