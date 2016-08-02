defmodule Elixirfiretruck.IncidentResolver do
  alias Elixirfiretruck.Incident
  alias Elixirfiretruck.Repo

  def all(_args, _info) do
    {:ok, Repo.all(Incident)}
  end

  def find(%{id: id}, _info) do
    case Repo.get(Incident, id) do
      nil -> {:error, "Incident with id #{id} not found"}
      user -> {:ok, user}
    end
  end

  def create(args, _info) do
    %Incident{}
        |> Incident.changeset(args)
        |> Repo.insert
  end
end
