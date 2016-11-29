defmodule LifehopeAttendance.EventOccurrenceController do
  use LifehopeAttendance.Web, :controller

  alias LifehopeAttendance.EventOccurrence
  alias LifehopeAttendance.Event

  def index(conn, _params) do
    event_occurrences = Repo.all(EventOccurrence)
    render(conn, "index.html", event_occurrences: event_occurrences)
  end

  def new(conn, _params) do
    events = Repo.all(Event)


    changeset = EventOccurrence.changeset(%EventOccurrence{starts_at: Ecto.DateTime.from_erl(:erlang.localtime)})
    render(conn, "new.html", changeset: changeset, events: events)
  end

  def create(conn, %{"event_occurrence" => event_occurrence_params}) do
    events = Repo.all(Event)
    changeset = EventOccurrence.changeset(%EventOccurrence{}, event_occurrence_params)

    case Repo.insert(changeset) do
      {:ok, _event_occurrence} ->
        conn
        |> put_flash(:info, "Event occurrence created successfully.")
        |> redirect(to: event_occurrence_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset, events: events)
    end
  end

  def show(conn, %{"id" => id}) do
    event_occurrence = Repo.get!(EventOccurrence, id)
    render(conn, "show.html", event_occurrence: event_occurrence)
  end

  def edit(conn, %{"id" => id}) do
    events = Repo.all(Event)

    event_occurrence = Repo.get!(EventOccurrence, id)
    changeset = EventOccurrence.changeset(event_occurrence)
    render(conn, "edit.html", event_occurrence: event_occurrence, changeset: changeset, events: events)
  end

  def update(conn, %{"id" => id, "event_occurrence" => event_occurrence_params}) do
    events = Repo.all(Event)

    event_occurrence = Repo.get!(EventOccurrence, id)
    changeset = EventOccurrence.changeset(event_occurrence, event_occurrence_params)

    case Repo.update(changeset) do
      {:ok, event_occurrence} ->
        conn
        |> put_flash(:info, "Event occurrence updated successfully.")
        |> redirect(to: event_occurrence_path(conn, :show, event_occurrence))
      {:error, changeset} ->
        render(conn, "edit.html", event_occurrence: event_occurrence, changeset: changeset, events: events)
    end
  end

  def delete(conn, %{"id" => id}) do
    event_occurrence = Repo.get!(EventOccurrence, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(event_occurrence)

    conn
    |> put_flash(:info, "Event occurrence deleted successfully.")
    |> redirect(to: event_occurrence_path(conn, :index))
  end
end
