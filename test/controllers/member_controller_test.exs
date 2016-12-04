defmodule LifehopeAttendance.MemberControllerTest do
  use LifehopeAttendance.ConnCase

  @username Application.get_env(:lifehope_attendance, :admin_auth)[:username]
  @password Application.get_env(:lifehope_attendance, :admin_auth)[:password]

  defp using_basic_auth(conn, username, password) do
    header_content = "Basic " <> Base.encode64("#{username}:#{password}")
    conn |> put_req_header("authorization", header_content)
  end

  alias LifehopeAttendance.Member
  @valid_attrs %{first_name: "some content", last_name: "some content"}
  @invalid_attrs %{}

  test "lists all entries on index", %{conn: conn} do
    conn = conn
      |> using_basic_auth(@username, @password)
      |> get member_path(conn, :index)
    assert html_response(conn, 200) =~ "Members"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = conn
      |> using_basic_auth(@username, @password)
      |> get member_path(conn, :new)
    assert html_response(conn, 200) =~ "New member"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = conn
      |> using_basic_auth(@username, @password)
      |> post member_path(conn, :create), member: @valid_attrs
    assert redirected_to(conn) == member_path(conn, :index)
    assert Repo.get_by(Member, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = conn
      |> using_basic_auth(@username, @password)
      |> post member_path(conn, :create), member: @invalid_attrs
    assert html_response(conn, 200) =~ "New member"
  end

  test "shows chosen resource", %{conn: conn} do
    member = Repo.insert! %Member{}
    conn = conn
      |> using_basic_auth(@username, @password)
      |> get member_path(conn, :show, member)
    assert html_response(conn, 200) =~ "Show member"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      conn = conn
        |> using_basic_auth(@username, @password)
        |> get member_path(conn, :show, -1)
    end
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    member = Repo.insert! %Member{}
    conn = conn
      |> using_basic_auth(@username, @password)
      |> get member_path(conn, :edit, member)
    assert html_response(conn, 200) =~ "Edit member"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    member = Repo.insert! %Member{}
    conn = conn
      |> using_basic_auth(@username, @password)
      |> put member_path(conn, :update, member), member: @valid_attrs
    assert redirected_to(conn) == member_path(conn, :show, member)
    assert Repo.get_by(Member, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    member = Repo.insert! %Member{}
    conn = conn
      |> using_basic_auth(@username, @password)
      |> put member_path(conn, :update, member), member: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit member"
  end

  test "deletes chosen resource", %{conn: conn} do
    member = Repo.insert! %Member{}
    conn = conn
      |> using_basic_auth(@username, @password)
      |> delete member_path(conn, :delete, member)
    assert redirected_to(conn) == member_path(conn, :index)
    refute Repo.get(Member, member.id)
  end
end
