defmodule LifehopeAttendance.PageController do
  use LifehopeAttendance.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end

end
