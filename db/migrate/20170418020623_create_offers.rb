class CreateOffers < ActiveRecord::Migration[5.0]
  def change
    create_table(:offers) do |t|
      t.column(:event_id, :int)
      t.column(:user_id, :int)
      t.column(:price, :int)
      t.column(:type, :boolean)

      t.timestamps()
    end
  end
end
