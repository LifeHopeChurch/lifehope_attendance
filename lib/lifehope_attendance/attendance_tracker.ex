defmodule LifehopeAttendance.AttendanceTracker do

  import Ecto.Query

  alias LifehopeAttendance.Event
  alias LifehopeAttendance.Member
  alias LifehopeAttendance.EventOccurrence
  alias LifehopeAttendance.Repo
  alias LifehopeAttendance.Attendance

  def tracking_data_for(event_occurrence_id) do
    query = from Member, order_by: [asc: :last_name, asc: :first_name]

    event_occurrence = Repo.get!(EventOccurrence, event_occurrence_id)
    attendees = Repo.all(from d in Attendance, where: d.event_occurrence_id == ^event_occurrence_id)
    members = Repo.all(query) |> Enum.map(fn(member) -> map_member_for_view(member, attendees) end)
    event_occurrence
      |> Map.put(:members, members)
      |> Map.put(:attendees, attendees)
  end

  defp map_member_for_view(member, attendees) do
    %{
      id: member.id,
      name: "#{member.last_name}, #{member.first_name}",
      attendee: attendee_for_member(member.id, attendees)
    }
  end

  defp attendee_for_member(member_id, attendees) do
    Enum.find(attendees, fn(attendee) -> attendee.member_id == member_id end)
  end
end
