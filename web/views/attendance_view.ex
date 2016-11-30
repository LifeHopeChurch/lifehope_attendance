defmodule LifehopeAttendance.AttendanceView do
  use LifehopeAttendance.Web, :view
  alias LifehopeAttendance.Event
  alias LifehopeAttendance.Member
  alias LifehopeAttendance.EventOccurrence
  alias LifehopeAttendance.Repo

  def members do
    Repo.all(Member)
  end

  def event_occurrences do
    Repo.all(EventOccurrence)
  end
end
