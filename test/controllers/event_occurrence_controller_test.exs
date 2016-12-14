defmodule LifehopeAttendance.EventOccurrenceControllerTest do
  use LifehopeAttendance.ConnCase
  alias LifehopeAttendance.Event

  alias LifehopeAttendance.EventOccurrence
  @valid_attrs %{starts_at: %{day: 17, hour: 14, min: 0, month: 4, sec: 0, year: 2010}, event_id: 1}
  @invalid_attrs %{}

  test "lists all entries on index", %{conn: conn} do
    conn = conn
      |> get event_occurrence_path(conn, :index)
    assert html_response(conn, 200) =~ "Sessions"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = conn
      |> get event_occurrence_path(conn, :new)
    assert html_response(conn, 200) =~ "New event occurrence"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    {:ok, event} = Event.changeset(%Event{}, %{ name: "Test event" }) |> Repo.insert
    valid_attrs = Map.merge(@valid_attrs, %{event_id: event.id})

    conn = conn
      |> post event_occurrence_path(conn, :create), event_occurrence: valid_attrs
    event_occurrence = Repo.get_by(EventOccurrence, valid_attrs)
    assert event_occurrence
    assert redirected_to(conn) == event_occurrence_event_attendance_path(conn, :index, event_occurrence)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = conn
      |> post event_occurrence_path(conn, :create), event_occurrence: @invalid_attrs
    assert html_response(conn, 200) =~ "New event occurrence"
  end

  test "shows chosen resource", %{conn: conn} do
    event_occurrence = Repo.insert! %EventOccurrence{}
    conn = conn
      |> get event_occurrence_path(conn, :show, event_occurrence)
    assert html_response(conn, 200) =~ "Show event occurrence"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      conn = conn
        |> get event_occurrence_path(conn, :show, -1)
    end
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    event_occurrence = Repo.insert! %EventOccurrence{}
    conn = conn
      |> get event_occurrence_path(conn, :edit, event_occurrence)
    assert html_response(conn, 200) =~ "Edit event occurrence"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    {:ok, event} = Event.changeset(%Event{}, %{ name: "Test event" }) |> Repo.insert
    valid_attrs = Map.merge(@valid_attrs, %{event_id: event.id})

    event_occurrence = Repo.insert! %EventOccurrence{event_id: event.id}
    conn = conn
      |> put event_occurrence_path(conn, :update, event_occurrence), event_occurrence: valid_attrs
    assert redirected_to(conn) == event_occurrence_path(conn, :show, event_occurrence)
    assert Repo.get_by(EventOccurrence, valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    {:ok, event} = Event.changeset(%Event{}, %{ name: "Test event" }) |> Repo.insert
    valid_attrs = Map.merge(@valid_attrs, %{event_id: event.id})

    event_occurrence = Repo.insert! %EventOccurrence{}
    conn = conn
      |> put event_occurrence_path(conn, :update, event_occurrence), event_occurrence: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit event occurrence"
  end

  test "deletes chosen resource", %{conn: conn} do
    event_occurrence = Repo.insert! %EventOccurrence{}
    conn = conn
      |> delete event_occurrence_path(conn, :delete, event_occurrence)
    assert redirected_to(conn) == event_occurrence_path(conn, :index)
    refute Repo.get(EventOccurrence, event_occurrence.id)
  end
end
