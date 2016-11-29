defmodule LifehopeAttendance.AttendanceControllerTest do
  use LifehopeAttendance.ConnCase

  alias LifehopeAttendance.Attendance
  @valid_attrs %{}
  @invalid_attrs %{}

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, attendance_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing attendances"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, attendance_path(conn, :new)
    assert html_response(conn, 200) =~ "New attendance"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, attendance_path(conn, :create), attendance: @valid_attrs
    assert redirected_to(conn) == attendance_path(conn, :index)
    assert Repo.get_by(Attendance, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, attendance_path(conn, :create), attendance: @invalid_attrs
    assert html_response(conn, 200) =~ "New attendance"
  end

  test "shows chosen resource", %{conn: conn} do
    attendance = Repo.insert! %Attendance{}
    conn = get conn, attendance_path(conn, :show, attendance)
    assert html_response(conn, 200) =~ "Show attendance"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, attendance_path(conn, :show, -1)
    end
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    attendance = Repo.insert! %Attendance{}
    conn = get conn, attendance_path(conn, :edit, attendance)
    assert html_response(conn, 200) =~ "Edit attendance"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    attendance = Repo.insert! %Attendance{}
    conn = put conn, attendance_path(conn, :update, attendance), attendance: @valid_attrs
    assert redirected_to(conn) == attendance_path(conn, :show, attendance)
    assert Repo.get_by(Attendance, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    attendance = Repo.insert! %Attendance{}
    conn = put conn, attendance_path(conn, :update, attendance), attendance: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit attendance"
  end

  test "deletes chosen resource", %{conn: conn} do
    attendance = Repo.insert! %Attendance{}
    conn = delete conn, attendance_path(conn, :delete, attendance)
    assert redirected_to(conn) == attendance_path(conn, :index)
    refute Repo.get(Attendance, attendance.id)
  end
end
