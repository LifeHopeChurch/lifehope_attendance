defmodule LifehopeAttendance.PageControllerTest do
  use LifehopeAttendance.ConnCase

  alias LifehopeAttendance.User

  setup %{conn: conn} do
    user = %User{name: "test", email: "test@example.com", id: 1}
    {:ok, conn: assign(conn, :current_user, user), user: user}
  end

  test "GET /", %{conn: conn} do
    conn = conn
      |> get("/")
    assert html_response(conn, 200) =~ "Sessions"
  end
end
