defmodule LifehopeAttendance.Repo.Migrations.CreateAttendance do
  use Ecto.Migration

  def change do
    create table(:attendances) do
      add :event_occurrence_id, references(:event_occurrences, on_delete: :nothing)
      add :member_id, references(:members, on_delete: :nothing)

      timestamps()
    end
    create index(:attendances, [:event_occurrence_id])
    create index(:attendances, [:member_id])

  end
end
