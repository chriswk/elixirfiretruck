defmodule Elixirfiretruck.Schema do
  use Absinthe.Schema
  import_types Elixirfiretruck.Schema.Types

  query do

    @desc "Get all incidents"
    field :incidents, list_of(:incident) do
      resolve &Elixirfiretruck.IncidentResolver.all/2
    end

    @desc "Get incident with id"
    field :incident, type: :incident do
      arg :id, non_null(:id)
      resolve &Elixirfiretruck.IncidentResolver.find/2
    end
  end

  mutation do
    @desc "Save an incident"
    field :incident, type: :incident do
      arg :name, non_null(:string)
      arg :client, :string
      arg :dc, :string
      arg :command, :string
      arg :duration, :float
      arg :finn_app, :string
      arg :finn_env, :string
      arg :output, :string

      resolve &Elixirfiretruck.IncidentResolver.create/2
    end
  end

end
