defmodule LifehopeAttendance.Member do
  use LifehopeAttendance.Web, :model

  schema "members" do
    field :first_name, :string
    field :last_name, :string
    field :email, :string
    field :notes, :string

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:first_name, :last_name, :email, :notes])
    |> validate_required([:first_name, :last_name, :email, :notes])
  end
end
