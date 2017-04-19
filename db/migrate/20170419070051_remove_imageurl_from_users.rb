class RemoveImageurlFromUsers < ActiveRecord::Migration[5.0]
  def change
    remove_column(:users, :imageurl, :string)
    remove_column(:users, :name, :string)
    remove_column(:users, :phone_number, :string)
    remove_column(:users, :email, :string)
  end
end
