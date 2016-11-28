defmodule LifehopeAttendance.MemberTest do
  use LifehopeAttendance.ModelCase

  alias LifehopeAttendance.Member

  @valid_attrs %{email: "some content", first_name: "some content", last_name: "some content", notes: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Member.changeset(%Member{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Member.changeset(%Member{}, @invalid_attrs)
    refute changeset.valid?
  end
end
