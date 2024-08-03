class AddImagesToDiaries < ActiveRecord::Migration[7.1]
  def change
    add_column :diaries, :images, :json
  end
end
