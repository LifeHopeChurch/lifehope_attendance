defmodule LifehopeAttendance.EventAttendanceController do
  use LifehopeAttendance.Web, :controller
  plug BasicAuth, use_config: {:lifehope_attendance, :admin_auth}

  alias LifehopeAttendance.Attendance
  alias LifehopeAttendance.EventOccurrence

  def index(conn, %{"event_occurrence_id" => event_occurrence_id}) do
    event_occurrence = Repo.get!(EventOccurrence, event_occurrence_id)
    attendees = Repo.all(from d in Attendance, where: d.event_occurrence_id == ^event_occurrence_id)


    render(conn, "index.html", event_occurrence: event_occurrence, attendees: attendees)
  end

  def create(conn, %{"event_occurrence_id" => event_occurrence_id, "member_id" => member_id}) do
    event_occurrence = Repo.get!(EventOccurrence, event_occurrence_id)
    changeset = Attendance.changeset(%Attendance{}, %{"event_occurrence_id" => event_occurrence_id, "member_id" => member_id})

    case Repo.insert(changeset) do
      {:ok, _attendance} ->
        conn
        # |> put_flash(:info, "Attendance created successfully.")
        |> redirect(to: event_occurrence_event_attendance_path(conn, :index, event_occurrence))
      {:error, changeset} ->
        render(conn, "index.html", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    attendance = Repo.get!(Attendance, id)
    event_occurrence = Repo.get!(EventOccurrence, attendance.event_occurrence_id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(attendance)

    conn
    # |> put_flash(:info, "Attendance deleted successfully.")
    |> redirect(to: event_occurrence_event_attendance_path(conn, :index, event_occurrence))
  end

end
