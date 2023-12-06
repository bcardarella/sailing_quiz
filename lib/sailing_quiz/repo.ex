defmodule SailingQuiz.Repo do
  use Ecto.Repo,
    otp_app: :sailing_quiz,
    adapter: Ecto.Adapters.Postgres
end
