class CreateEvents < ActiveRecord::Migration[5.0]
  def change
    create_table(:events) do |t|
      t.column(:name, :string)
      t.column(:date, :datetime)
      t.column(:imageurl, :string)
      t.column(:duration, :integer)

      t.timestamps()
    end
  end
end
