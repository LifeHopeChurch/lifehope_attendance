defmodule LifehopeAttendance.PageController do
  use LifehopeAttendance.Web, :controller
  plug BasicAuth, use_config: {:lifehope_attendance, :admin_auth}

  def index(conn, _params) do
    render conn, "index.html"
  end
end
