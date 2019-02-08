defmodule ElixirTrelloWeb.BoardController do
  use ElixirTrelloWeb, :controller

  alias ElixirTrello.Boards
  alias ElixirTrello.Boards.Board

  action_fallback ElixirTrelloWeb.FallbackController

  def index(conn, _params) do
    boards = Boards.list_boards()
    render(conn, "index.json", boards: boards)
  end

  def create(conn, %{"board" => board_params}) do
    {:ok, %Board{} = board_created} = Boards.create_board(board_params)

    with board <- Boards.with_lists(board_created) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.board_path(conn, :show, board))
      |> render("show.json", board: board)
    end
  end

  def show(conn, %{"id" => id}) do
    board = Boards.get_board!(id)
    render(conn, "show.json", board: board)
  end

  def update(conn, %{"id" => id, "board" => board_params}) do
    board = Boards.get_board!(id)

    with {:ok, %Board{} = board} <- Boards.update_board(board, board_params) do
      render(conn, "show.json", board: board)
    end
  end

  def delete(conn, %{"id" => id}) do
    board = Boards.get_board!(id)

    with {:ok, %Board{}} <- Boards.delete_board(board) do
      send_resp(conn, :no_content, "")
    end
  end
end
