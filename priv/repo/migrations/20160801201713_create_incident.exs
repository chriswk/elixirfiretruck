defmodule Elixirfiretruck.Repo.Migrations.CreateIncident do
  use Ecto.Migration

  def change do
    create table(:incidents) do
      add :name, :string
      add :client, :string
      add :dc, :string
      add :command, :string
      add :duration, :float
      add :finn_app, :string
      add :finn_env, :string
      add :output, :string

      timestamps()
    end

  end
end
