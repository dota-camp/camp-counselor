defmodule Counselor.Question do
  use Ecto.Schema

  import Ecto.Changeset

  schema "questions" do
    field :content, :string
    field :patch, :string
    belongs_to :member, Counselor.Member
    has_many :answers, Counselor.Answer

    timestamps()
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
    |> cast(params, [:content, :patch])
    |> validate_required([:content, :member])
    |> cast_assoc(:member, required: true, with: &Counselor.Member.changeset/2)
    |> cast_assoc(:answers, required: false, with: &Counselor.Answer.changeset/2)
  end
end

defmodule Counselor.Answer do
  use Ecto.Schema

  import Ecto.Changeset

  schema "answers" do
    field :content, :string
    belongs_to :question, Counselor.Question
    belongs_to :member, Counselor.Member

    timestamps()
  end

  def changeset(answer, params \\ {}) do
    answer
    |> cast(params, [:content])
    |> validate_required([:content])
  end
end

defmodule Counselor.Member do
  use Ecto.Schema

  import Ecto.Changeset

  schema "members" do
    field :discord_id, :string
    has_many :questions, Counselor.Question
    has_many :answers, Counselor.Question
  end

  def changeset(member, params \\ {}) do
    member
    |> cast(params, [:discord_id])
    |> validate_required([:discord_id])
    |> unique_constraint(:discord_id)
  end
end
