defmodule LifehopeAttendance.Attendance do
  use LifehopeAttendance.Web, :model

  schema "attendances" do
    belongs_to :event_occurrence, LifehopeAttendance.EventOccurrence
    belongs_to :member, LifehopeAttendance.Member

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [])
    |> validate_required([])
  end
end
