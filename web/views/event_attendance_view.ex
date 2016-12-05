defmodule LifehopeAttendance.EventAttendanceView do
  use LifehopeAttendance.Web, :view

  import Ecto.Query

  alias LifehopeAttendance.Event
  alias LifehopeAttendance.Member
  alias LifehopeAttendance.EventOccurrence
  alias LifehopeAttendance.Repo
  alias LifehopeAttendance.Attendance

  def event(event_occurrence) do
    Repo.get!(Event, event_occurrence.event_id)
  end

  def display_datetime(datetime) do
    "#{datetime.month}/#{datetime.day}/#{datetime.year} #{datetime.hour |> rem(12)}:#{datetime.min}  "
  end

  def members do
    Repo.all(Member)
  end

  def member_name(member) do
    "#{member.last_name}, #{member.first_name}"
  end

  def attending?(event_occurrence, member) do
    attendance(event_occurrence, member)
  end

  def attendance(event_occurrence, member) do
    query = from a in Attendance,
            where: a.member_id == ^member.id
               and a.event_occurrence_id == ^event_occurrence.id
    Repo.all(query) |> List.first
  end
end
