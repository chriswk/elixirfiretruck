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

  def eventToParams(event) do
    %{:name => event["check"], :dc => event["dc"],
        :client => event["client"], :command => event["last_result"]["command"],
        :duration => event["last_result"]["duration"], :output => event["last_result"]["output"],
        :finn_app => event["last_result"]["finn_app"], :finn_env => event["last_result"]["finn_env"]}
  end

  def incToChangeset(event) do
    Incident.changeset(%Incident{}, event)
  end

  def importEvent(conn, %{"incident" => event}) do
    incident_params = eventToParams(event)
    create(conn, %{"incident" => incident_params})
  end

  def bulkImport(conn, %{"incidents" => incidents}) do
    result = incidents
        |> Enum.map(fn event -> eventToParams(event) end)
        |> Enum.map(fn event -> incToChangeset(event) end)
        |> Enum.map(fn changeset -> Repo.insert(changeset) end)
        |> Enum.filter(fn status -> elem(status, 0) !== :ok end)

    json conn, result
  end
end
