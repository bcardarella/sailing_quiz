defmodule SailingQuiz.Repo.Migrations.CreateCards do
  use Ecto.Migration

  def change do
    create table(:cards) do
      add :question, :string
      add :answer, :string

      timestamps(type: :utc_datetime)
    end
  end
end
