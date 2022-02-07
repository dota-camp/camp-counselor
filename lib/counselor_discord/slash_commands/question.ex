defmodule CounselorDiscord.SlashCommands.Question do
  @moduledoc """
  Handles /question command
  """

  @spec get_command() :: map()
  def get_command,
    do: %{
      name: "question",
      description: "Ask a question about any aspect of dota2"
    }

  @spec handle_interaction(Interaction.t()) :: map()
  def handle_interaction(_interaction) do
    IO.puts("hello world!")
  end
end
