defmodule Elixirfiretruck.Router do
  use Elixirfiretruck.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", Elixirfiretruck do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
  end

  # Other scopes may use custom stacks.
  scope "/api", Elixirfiretruck do
     pipe_through :api
     resources "/incidents", IncidentController
     post "/incidents/import", IncidentController, :importEvent
     post "/incidents/bulk", IncidentController, :bulkImport

   end

   forward "/graphql", Absinthe.Plug,
    schema: Elixirfiretruck.Schema

   get "/graphiql", Absinthe.Plug.GraphiQL, schema: Elixirfiretruck.Schema
   post "/graphiql", Absinthe.Plug, schema: Elixirfiretruck.Schema
end
