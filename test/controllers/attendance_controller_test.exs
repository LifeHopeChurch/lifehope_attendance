defmodule LifehopeAttendance.AttendanceControllerTest do
  use LifehopeAttendance.ConnCase

  alias LifehopeAttendance.Event
  alias LifehopeAttendance.EventOccurrence
  alias LifehopeAttendance.Member
  alias LifehopeAttendance.Attendance
  alias LifehopeAttendance.User

  @valid_attrs %{event_occurrence_id: 1, member_id: 1}
  @invalid_attrs %{}

  setup %{conn: conn} do
    user = %User{name: "test", email: "test@example.com", id: 1}
    {:ok, conn: assign(conn, :current_user, user), user: user}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = conn
      |> get attendance_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing attendances"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = conn
      |> get attendance_path(conn, :new)
    assert html_response(conn, 200) =~ "New attendance"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    event = Repo.insert! %Event{ name: "Test event" }
    event_occurrence = Repo.insert! %EventOccurrence{event_id: event.id}
    member = Repo.insert! %Member{first_name: "Joe", last_name: "Tester"}
    valid_attrs = Map.merge(@valid_attrs, %{event_occurrence_id: event_occurrence.id, member_id: member.id})

    conn = conn
      |> post attendance_path(conn, :create), attendance: valid_attrs
    assert redirected_to(conn) == attendance_path(conn, :index)
    assert Repo.get_by(Attendance, valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = conn
      |> post attendance_path(conn, :create), attendance: @invalid_attrs
    assert html_response(conn, 200) =~ "New attendance"
  end

  test "shows chosen resource", %{conn: conn} do
    attendance = Repo.insert! %Attendance{}
    conn = conn
      |> get attendance_path(conn, :show, attendance)
    assert html_response(conn, 200) =~ "Show attendance"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      conn = conn
        |> get attendance_path(conn, :show, -1)
    end
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    attendance = Repo.insert! %Attendance{}
    conn = conn
      |> get attendance_path(conn, :edit, attendance)
    assert html_response(conn, 200) =~ "Edit attendance"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    event = Repo.insert! %Event{ name: "Test event" }
    event_occurrence = Repo.insert! %EventOccurrence{event_id: event.id}
    member = Repo.insert! %Member{first_name: "Joe", last_name: "Tester"}
    valid_attrs = Map.merge(@valid_attrs, %{event_occurrence_id: event_occurrence.id, member_id: member.id})

    attendance = Repo.insert! %Attendance{}
    conn = conn
      |> put attendance_path(conn, :update, attendance), attendance: valid_attrs
    assert redirected_to(conn) == attendance_path(conn, :show, attendance)
    assert Repo.get_by(Attendance, valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    attendance = Repo.insert! %Attendance{}
    conn = conn
      |> put attendance_path(conn, :update, attendance), attendance: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit attendance"
  end

  test "deletes chosen resource", %{conn: conn} do
    attendance = Repo.insert! %Attendance{}
    conn = conn
      |> delete attendance_path(conn, :delete, attendance)
    assert redirected_to(conn) == attendance_path(conn, :index)
    refute Repo.get(Attendance, attendance.id)
  end
end
