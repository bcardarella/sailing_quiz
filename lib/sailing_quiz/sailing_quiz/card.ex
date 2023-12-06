defmodule SailingQuiz.Card do
  use Ecto.Schema
  import Ecto.Changeset

  schema "cards" do
    field :question, :string
    field :answer, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(card, attrs) do
    card
    |> cast(attrs, [:question, :answer])
    |> validate_required([:question, :answer])
  end
end
