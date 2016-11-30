defmodule LifehopeAttendance.AttendanceTest do
  use LifehopeAttendance.ModelCase

  alias LifehopeAttendance.Attendance

  @valid_attrs %{event_occurrence_id: 1, member_id: 1}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Attendance.changeset(%Attendance{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Attendance.changeset(%Attendance{}, @invalid_attrs)
    refute changeset.valid?
  end
end
