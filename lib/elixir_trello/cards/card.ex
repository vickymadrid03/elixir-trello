defmodule ElixirTrello.Cards.Card do
  use Ecto.Schema
  import Ecto.Changeset

  schema "cards" do
    field :text, :string
    field :list_id, :id

    timestamps()
  end

  @doc false
  def changeset(card, attrs) do
    card
    |> cast(attrs, [:text])
    |> validate_required([:text])
    |> foreign_key_constraint(:list_id)
  end
end
