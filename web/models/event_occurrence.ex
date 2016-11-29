defmodule LifehopeAttendance.EventOccurrence do
  use LifehopeAttendance.Web, :model

  schema "event_occurrences" do
    field :starts_at, Ecto.DateTime
    belongs_to :event, LifehopeAttendance.Event

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:starts_at])
    |> validate_required([:starts_at])
    |> cast(params, [:event_id])
    |> validate_required([:event_id])
  end
end
