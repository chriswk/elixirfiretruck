defmodule Elixirfiretruck.Incident do
  use Elixirfiretruck.Web, :model
  schema "incidents" do
    field :name, :string
    field :client, :string
    field :dc, :string
    field :command, :string
    field :duration, :float
    field :finn_app, :string
    field :finn_env, :string
    field :output, :string

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :client, :dc, :command, :duration, :finn_app, :finn_env, :output])
    |> validate_required([:name, :client, :dc, :command, :duration, :finn_app, :finn_env, :output])
  end
end
