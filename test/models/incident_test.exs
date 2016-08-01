defmodule Elixirfiretruck.IncidentTest do
  use Elixirfiretruck.ModelCase

  alias Elixirfiretruck.Incident

  @valid_attrs %{client: "some content", command: "some content", dc: "some content", duration: "120.5", finn_app: "some content", finn_env: "some content", name: "some content", output: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Incident.changeset(%Incident{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Incident.changeset(%Incident{}, @invalid_attrs)
    refute changeset.valid?
  end
end
