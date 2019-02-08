defmodule ElixirTrelloWeb.ListController do
  use ElixirTrelloWeb, :controller

  alias ElixirTrello.Boards
  alias ElixirTrello.Boards.Board
  alias ElixirTrello.Boards.List
  alias ElixirTrello.Repo

  action_fallback ElixirTrelloWeb.FallbackController

  def index(conn, _params) do
    lists = Boards.list_lists()
    render(conn, "index.json", lists: lists)
  end

  # TODO: validate presence of board_id
  def create(conn, %{"list" => list_params, "board_id" => board_id}) do
    with {:ok, %List{} = list} <- Boards.create_list(list_params, board_id) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.list_path(conn, :show, list))
      |> render("show.json", list: list)
    end
  end

  def show(conn, %{"id" => id}) do
    list = Boards.get_list!(id)
    render(conn, "show.json", list: list)
  end

  def update(conn, %{"id" => id, "list" => list_params}) do
    list = Boards.get_list!(id)

    with {:ok, %List{} = list} <- Boards.update_list(list, list_params) do
      render(conn, "show.json", list: list)
    end
  end

  def delete(conn, %{"id" => id}) do
    list = Boards.get_list!(id)

    with {:ok, %List{}} <- Boards.delete_list(list) do
      send_resp(conn, :no_content, "")
    end
  end
end
