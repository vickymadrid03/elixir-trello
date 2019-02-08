defmodule ElixirTrello.Boards.List do
  use Ecto.Schema
  import Ecto.Changeset


  schema "lists" do
    field :name, :string
    field :board_id, :id

    timestamps()
  end

  @doc false
  def changeset(list, attrs) do
    list
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
