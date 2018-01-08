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
alias LifehopeAttendance.Repo
alias LifehopeAttendance.Member
alias LifehopeAttendance.Event

for _ <- 1..10 do
  Repo.insert! %Member{
    first_name: FakerElixir.Name.first_name,
    last_name: FakerElixir.Name.last_name
  }
end

Repo.insert! %Event{
  name: "Life Classes",
}

Repo.insert! %Event{
  name: "Sunday Worship",
}
