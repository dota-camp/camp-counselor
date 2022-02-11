defmodule Counselor.Repo.Migrations.AddMembersAndQuestions do
  use Ecto.Migration

  def change do
    create table(:answers) do
      add :content, :string

      timestamps()
    end

    create table(:questions) do
      add :content, :string
      add :patch, :string
      add :answer_id, references(:answers)

      timestamps()
    end

    create table(:members) do
      add :discord_id, :string
      add :answer_id, references(:answers)
      add :question_id, references(:questions)
    end

    # A unique index will enforce only one discord_id per
    # member entry.
    #
    create unique_index(:members, [:discord_id])

    alter table(:questions) do
      add :member_id, references(:members)
    end

    alter table(:answers) do
      add :question_id, references(:questions)
      add :member_id, references(:members)
    end
  end
end
