defmodule LifehopeAttendance.EventOccurrenceTest do
  use LifehopeAttendance.ModelCase

  alias LifehopeAttendance.EventOccurrence

  @valid_attrs %{starts_at: %{day: 17, hour: 14, min: 0, month: 4, sec: 0, year: 2010}, event_id: 1}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = EventOccurrence.changeset(%EventOccurrence{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = EventOccurrence.changeset(%EventOccurrence{}, @invalid_attrs)
    refute changeset.valid?
  end
end
