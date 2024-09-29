class AddSpecialCharactersToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :special_characters, :string
  end
end
