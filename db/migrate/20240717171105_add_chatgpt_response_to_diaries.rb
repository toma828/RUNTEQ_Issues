class AddChatgptResponseToDiaries < ActiveRecord::Migration[7.1]
  def change
    add_column :diaries, :chatgpt_response, :text
  end
end
