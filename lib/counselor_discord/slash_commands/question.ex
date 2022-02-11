defmodule CounselorDiscord.SlashCommands.Question do
  @moduledoc """
  Handles /question command
  """

  require Logger

  import Nostrum.Struct.Embed

  alias Counselor.{Repo, Member}

  @spec get_command() :: map()
  def get_command,
    do: %{
      name: "question",
      description: "Ask a question about any aspect of dota2",
      options: [
        %{
          type: 3,
          name: "content",
          description: "The question you'd like to ask.",
          required: true
        }
      ]
    }

  def handle_interaction(interaction, content) do
    member_record = %Member{
      discord_id: Integer.to_string(interaction.member.user.id)
    }

    # A 'transaction' is where the entire set of changes is one atomic operation. Every
    # action in this function will either pass or fail as one.
    #
    # First, take the Member struct and insert it into the database. The on_conflict param
    # will ensure an 'upsert' operation where if the member already exists then the insert
    # operation will do nothing and the existing record for that member will be returned
    # instead.
    #
    # Then use the build_assoc function to build an association with a new Question struct and
    # insert it into the database. The build_assoc isn't really too magical; all it really
    # does is take member_id out of member and insert it into the question entry. The
    # member_id is whats needed to create the 'belongs_to' association between a member and
    # the question they are asking.
    #
    {:ok, question} = Repo.transaction fn ->
      member = Repo.insert!(member_record, on_conflict: :nothing)
      question = Ecto.build_assoc(member, :questions, %{content: content})
      Repo.insert!(question)
    end

    embed =
      %Nostrum.Struct.Embed{}
      |> put_title("A question was asked!")
      |> put_field("Questioner", "<@#{member_record.discord_id}>", true)
      |> put_field("Question", content)
      |> put_field("Question ID", question.id)
      |> put_field("How to answer", "Use the /answer command and pass the ID for this question as the first argument")

    %{embeds: [embed]}
  end
end
