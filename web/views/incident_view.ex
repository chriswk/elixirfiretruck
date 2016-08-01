defmodule Elixirfiretruck.IncidentView do
  use Elixirfiretruck.Web, :view

  def render("index.json", %{incidents: incidents}) do
    %{data: render_many(incidents, Elixirfiretruck.IncidentView, "incident.json")}
  end

  def render("show.json", %{incident: incident}) do
    %{data: render_one(incident, Elixirfiretruck.IncidentView, "incident.json")}
  end

  def render("incident.json", %{incident: incident}) do
    %{id: incident.id,
      name: incident.name,
      client: incident.client,
      dc: incident.dc,
      command: incident.command,
      duration: incident.duration,
      finn_app: incident.finn_app,
      finn_env: incident.finn_env,
      output: incident.output}
  end
end
