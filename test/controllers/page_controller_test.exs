defmodule LifehopeAttendance.PageControllerTest do
  use LifehopeAttendance.ConnCase

  test "GET /", %{conn: conn} do
    conn = get conn, "/"
    assert html_response(conn, 200) =~ "Sessions"
  end
end
