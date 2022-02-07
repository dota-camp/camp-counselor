defmodule Counselor.Repo.Migrations.AddMembersAndQuestions do
  use Ecto.Migration

  def change do
    create table(:members) do
      add :discord_nick, :string
    end

    create table(:answers) do
      add :answer, :string
      add :answerer, references(:members)
    end

    create table(:questions) do
      add :question, :string
      add :patch, :integer
      add :asker, references(:members)
      add :answers, references(:answers)
    end
  end
end
