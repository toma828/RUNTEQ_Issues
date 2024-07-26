class AddLastChatgptUseToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :last_chatgpt_use, :datetime
  end
end