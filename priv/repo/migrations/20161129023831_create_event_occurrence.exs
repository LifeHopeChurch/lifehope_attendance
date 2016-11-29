defmodule LifehopeAttendance.Repo.Migrations.CreateEventOccurrence do
  use Ecto.Migration

  def change do
    create table(:event_occurrences) do
      add :starts_at, :datetime
      add :event_id, references(:events, on_delete: :nothing)

      timestamps()
    end
    create index(:event_occurrences, [:event_id])

  end
end
