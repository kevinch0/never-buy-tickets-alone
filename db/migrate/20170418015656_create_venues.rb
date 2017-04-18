class CreateVenues < ActiveRecord::Migration[5.0]
  def change
    create_table(:venues) do |t|
      t.column(:name, :string)
      t.column(:address, :string)
      t.column(:imageurl, :string)

      t.timestamps()
    end
  end
end
