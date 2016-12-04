defmodule LifehopeAttendance.EventControllerTest do
  use LifehopeAttendance.ConnCase

  @username Application.get_env(:lifehope_attendance, :admin_auth)[:username]
  @password Application.get_env(:lifehope_attendance, :admin_auth)[:password]

  defp using_basic_auth(conn, username, password) do
    header_content = "Basic " <> Base.encode64("#{username}:#{password}")
    conn |> put_req_header("authorization", header_content)
  end

  alias LifehopeAttendance.Event
  @valid_attrs %{name: "some content"}
  @invalid_attrs %{}

  test "lists all entries on index", %{conn: conn} do
    conn = conn
      |> using_basic_auth(@username, @password)
      |> get event_path(conn, :index)
    assert html_response(conn, 200) =~ "Events"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = conn
      |> using_basic_auth(@username, @password)
      |> get event_path(conn, :new)
    assert html_response(conn, 200) =~ "New event"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = conn
      |> using_basic_auth(@username, @password)
      |> post event_path(conn, :create), event: @valid_attrs
    assert redirected_to(conn) == event_path(conn, :index)
    assert Repo.get_by(Event, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = conn
      |> using_basic_auth(@username, @password)
      |> post event_path(conn, :create), event: @invalid_attrs
    assert html_response(conn, 200) =~ "New event"
  end

  test "shows chosen resource", %{conn: conn} do
    event = Repo.insert! %Event{}
    conn = conn
      |> using_basic_auth(@username, @password)
      |> get event_path(conn, :show, event)
    assert html_response(conn, 200) =~ "Show event"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      conn = conn
        |> using_basic_auth(@username, @password)
        |> get event_path(conn, :show, -1)
    end
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    event = Repo.insert! %Event{}
    conn = conn
      |> using_basic_auth(@username, @password)
      |> get event_path(conn, :edit, event)
    assert html_response(conn, 200) =~ "Edit event"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    event = Repo.insert! %Event{}
    conn = conn
      |> using_basic_auth(@username, @password)
      |> put event_path(conn, :update, event), event: @valid_attrs
    assert redirected_to(conn) == event_path(conn, :show, event)
    assert Repo.get_by(Event, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    event = Repo.insert! %Event{}
    conn = conn
      |> using_basic_auth(@username, @password)
      |> put event_path(conn, :update, event), event: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit event"
  end

  test "deletes chosen resource", %{conn: conn} do
    event = Repo.insert! %Event{}
    conn = conn
      |> using_basic_auth(@username, @password)
      |> delete event_path(conn, :delete, event)
    assert redirected_to(conn) == event_path(conn, :index)
    refute Repo.get(Event, event.id)
  end
end
