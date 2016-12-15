# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     LifehopeAttendance.Repo.insert!(%LifehopeAttendance.SomeModel{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

LifehopeAttendance.Repo.delete_all LifehopeAttendance.User

LifehopeAttendance.User.changeset(%LifehopeAttendance.User{}, %{name: "Test User", email: "testuser@example.com", password: "secret", password_confirmation: "secret"})
|> LifehopeAttendance.Repo.insert!
|> Coherence.ControllerHelpers.confirm!
