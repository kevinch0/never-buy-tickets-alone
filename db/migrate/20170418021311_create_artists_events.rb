class CreateArtistsEvents < ActiveRecord::Migration[5.0]
  def change
    create_table(:artists_events) do |t|
      t.column(:event_id, :int)
      t.column(:artist_id, :int)
      
      t.timestamps()
    end
  end
end
