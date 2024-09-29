class AddLayoutToDiaries < ActiveRecord::Migration[7.1]
  def change
    add_column :diaries, :layout, :json
  end
end
