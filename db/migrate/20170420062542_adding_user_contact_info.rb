class AddingUserContactInfo < ActiveRecord::Migration[5.0]
  def change
add_column(:users, :phone_number, :varchar)
add_column(:users, :email, :varchar)

  end
end
