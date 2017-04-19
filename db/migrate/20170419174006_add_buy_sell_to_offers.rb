class AddBuySellToOffers < ActiveRecord::Migration[5.0]
  def change
  	add_column(:offers, :buy_sell, :boolean)
  end
end
