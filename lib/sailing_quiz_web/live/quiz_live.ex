defmodule SailingQuizWeb.QuizLive do
  use SailingQuizWeb, :live_view
  import Ecto.Query

  alias SailingQuiz.{Card, Repo}

  def render(assigns) do
    ~H"""
    <div>Questions: <%= @correct %> / <%= @total %></div>

    <div>Q: <%= @question.question %></div>
    <button :for={answer <- @answers}><span class="hover:cursor-pointer" phx-click="answer" phx-value-id={answer.id}><%= answer.answer %></span></button>
    """
  end

  def mount(_params, _session, socket) do
    {question, answers} = fetch_next_question_and_answers()

    {:ok, assign(socket, %{question: question, answers: answers, total: 0, correct: 0})}
  end

  def handle_event("answer", %{"id" => id}, socket) do
    {id, _} = Integer.parse(id)

    {question, answers} = fetch_next_question_and_answers()

    socket = if compare(socket.assigns.question.id, id) do
      socket
      |> put_flash(:info, "Correct!")
      |> assign(:correct, socket.assigns.correct + 1)
    else
      question = socket.assigns.question

      socket |> put_flash(:error, "Wrong! The correct answer was: #{question.answer}")
    end

    {:noreply, assign(socket, %{question: question, answers: answers, total: socket.assigns.total + 1})}
  end

  defp compare(id, id), do: true
  defp compare(_, _), do: false

  defp fetch_next_question_and_answers() do
    question = Repo.one!(from c in Card, order_by: fragment("random()"), limit: 1)

    answers =
      Repo.all(from c in Card, where: c.id != ^question.id, order_by: fragment("random()"), limit: 3)
      |> List.insert_at(-1, question)
      |> Enum.take_random(4)

    {question, answers}
  end
end