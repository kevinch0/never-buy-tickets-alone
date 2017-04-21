class ChangeOfferColumn < ActiveRecord::Migration[5.0]
  def change
    remove_column :offers, :price
    add_column :offers, :price, :varchar
  end
end
