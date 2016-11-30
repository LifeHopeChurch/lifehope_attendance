defmodule LifehopeAttendance.EventOccurrenceView do
  use LifehopeAttendance.Web, :view

  alias LifehopeAttendance.Event
  alias LifehopeAttendance.Repo

  def event_name(event_id) do
    Repo.get!(Event, event_id).name
  end

  def display_datetime(datetime) do
    "#{datetime.month}/#{datetime.day}/#{datetime.year} #{datetime.hour |> rem(12)}:#{datetime.min}  "
  end

  def events do
    Repo.all(Event)
  end
end
