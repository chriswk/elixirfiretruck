defmodule Elixirfiretruck.Repo.Migrations.CreateComment do
  use Ecto.Migration

  def change do
    create table(:comments) do
      add :name, :string
      add :content, :text
      add :incident_id, references(:incidents, on_delete: :nothing)

      timestamps()
    end
    create index(:comments, [:incident_id])

  end
end
