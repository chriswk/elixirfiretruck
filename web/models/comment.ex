defmodule Elixirfiretruck.Comment do
  use Elixirfiretruck.Web, :model

  schema "comments" do
    field :name, :string
    field :content, :string
    belongs_to :incident, Elixirfiretruck.Incident

    timestamps
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :content])
    |> validate_required([:name, :content])
  end
end
