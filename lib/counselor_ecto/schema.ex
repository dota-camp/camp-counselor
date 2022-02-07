defmodule Counselor.Question do
  use Ecto.Schema

  import Ecto.Changeset

  schema "questions" do
    field :question, :string
    field :patch, :string

    has_one :asker, Counselor.Member
    has_many :answers, Counselor.Answer
  end

  @spec changeset(
          {map, map}
          | %{
              :__struct__ => atom | %{:__changeset__ => map, optional(any) => any},
              optional(atom) => any
            },
          :invalid | %{optional(:__struct__) => none, optional(atom | binary) => any}
        ) :: Ecto.Changeset.t()
  def changeset(question, params \\ %{}) do
    question
    |> cast(params, [:question, :asker, :answers, :patch])
    |> validate_required([:question, :asker])
  end
end

defmodule Counselor.Answer do
  use Ecto.Schema

  import Ecto.Changeset

  schema "answers" do
    field :answer, :string
    has_one :answerer, Counselor.Member
  end

  def changeset(answer, params \\ {}) do
    answer
    |> cast(params, [:answer, :answerer])
    |> validate_required([:answer, :answerer])
  end
end

defmodule Counselor.Member do
  use Ecto.Schema

  import Ecto.Changeset

  schema "members" do
    field :discord_nick, :string
  end

  def changeset(member, params \\ {}) do
    member
    |> cast(params, [:discord_nick])
    |> validate_required([:discord_nick])
  end
end
