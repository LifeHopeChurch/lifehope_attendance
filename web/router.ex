defmodule LifehopeAttendance.Router do
  use LifehopeAttendance.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", LifehopeAttendance do
    pipe_through :browser # Use the default browser stack

    get "/", EventOccurrenceController, :index
    resources "/members", MemberController
    resources "/events", EventController
    resources "/event_occurrences", EventOccurrenceController do
      resources "/attendance", EventAttendanceController
      put "/attendance", EventAttendanceController, :visitor

    end
    resources "/attendances", AttendanceController
    resources "/record_attendances", RecordAttendanceController
  end

  # Other scopes may use custom stacks.
  # scope "/api", LifehopeAttendance do
  #   pipe_through :api
  # end
end
