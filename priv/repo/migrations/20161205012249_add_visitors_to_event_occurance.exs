defmodule LifehopeAttendance.Repo.Migrations.AddVisitorsToEventOccurance do
  use Ecto.Migration

  def change do
    alter table(:event_occurrences) do
      add :visitor_count, :integer
    end
  end
end
