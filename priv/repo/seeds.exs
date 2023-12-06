# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     SailingQuiz.Repo.insert!(%SailingQuiz.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.


alias SailingQuiz.{Card, Repo}

~w{A B C D E F G H I J K L}
|> Enum.each(fn(letter) ->
  Repo.insert!(%Card{question: "The answer is #{letter}", answer: letter})
end)