defmodule Elixirfiretruck.Schema.Types do
  use Absinthe.Schema.Notation

  object :incident do
    field :id, :id
    field :name, :string
    field :client, :string
    field :dc, :string
    field :command, :string
    field :duration, :float
    field :finn_app, :string
    field :finn_env, :string
    field :output, :string
    field :inserted_at, :time
    field :updated_at, :time
  end

  scalar :time, description: "ISOz time" do
    parse &Timex.parse!(&1, "{ISO:Extended:Z}")
    serialize &Timex.format!(&1, "{ISO:Extended:Z}")
  end
end
