defmodule LifehopeAttendance.EventAttendanceView do
  use LifehopeAttendance.Web, :view

  import Ecto.Query

  alias LifehopeAttendance.Event
  alias LifehopeAttendance.Member
  alias LifehopeAttendance.EventOccurrence
  alias LifehopeAttendance.Repo
  alias LifehopeAttendance.Attendance

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
