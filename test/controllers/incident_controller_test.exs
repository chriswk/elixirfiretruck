defmodule Elixirfiretruck.IncidentControllerTest do
  use Elixirfiretruck.ConnCase

  alias Elixirfiretruck.Incident
  @valid_attrs %{client: "some content", command: "some content", dc: "some content", duration: "120.5", finn_app: "some content", finn_env: "some content", name: "some content", output: "some content"}
  @invalid_attrs %{}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, incident_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "shows chosen resource", %{conn: conn} do
    incident = Repo.insert! %Incident{}
    conn = get conn, incident_path(conn, :show, incident)
    assert json_response(conn, 200)["data"] == %{"id" => incident.id,
      "name" => incident.name,
      "client" => incident.client,
      "dc" => incident.dc,
      "command" => incident.command,
      "duration" => incident.duration,
      "finn_app" => incident.finn_app,
      "finn_env" => incident.finn_env,
      "output" => incident.output}
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, incident_path(conn, :show, -1)
    end
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, incident_path(conn, :create), incident: @valid_attrs
    assert json_response(conn, 201)["data"]["id"]
    assert Repo.get_by(Incident, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, incident_path(conn, :create), incident: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    incident = Repo.insert! %Incident{}
    conn = put conn, incident_path(conn, :update, incident), incident: @valid_attrs
    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(Incident, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    incident = Repo.insert! %Incident{}
    conn = put conn, incident_path(conn, :update, incident), incident: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn} do
    incident = Repo.insert! %Incident{}
    conn = delete conn, incident_path(conn, :delete, incident)
    assert response(conn, 204)
    refute Repo.get(Incident, incident.id)
  end
end
