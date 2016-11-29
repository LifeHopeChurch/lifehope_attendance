defmodule LifehopeAttendance.AttendanceTest do
  use LifehopeAttendance.ModelCase

  alias LifehopeAttendance.Attendance

  @valid_attrs %{}
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
