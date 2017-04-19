class RemoveTypeFromOffers < ActiveRecord::Migration[5.0]
  def change
  	remove_column(:offers, :type, :boolean)
  end
end
