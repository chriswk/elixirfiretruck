defmodule Elixirfiretruck.IncidentController do
  use Elixirfiretruck.Web, :controller

  alias Elixirfiretruck.Incident

  def index(conn, _params) do
    incidents = Repo.all(Incident)
    render(conn, "index.json", incidents: incidents)
  end

  def create(conn, %{"incident" => incident_params}) do
    changeset = Incident.changeset(%Incident{}, incident_params)

    case Repo.insert(changeset) do
      {:ok, incident} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", incident_path(conn, :show, incident))
        |> render("show.json", incident: incident)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Elixirfiretruck.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    incident = Repo.get!(Incident, id)
    render(conn, "show.json", incident: incident)
  end

  def update(conn, %{"id" => id, "incident" => incident_params}) do
    incident = Repo.get!(Incident, id)
    changeset = Incident.changeset(incident, incident_params)

    case Repo.update(changeset) do
      {:ok, incident} ->
        render(conn, "show.json", incident: incident)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Elixirfiretruck.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    incident = Repo.get!(Incident, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(incident)

    send_resp(conn, :no_content, "")
  end
end
