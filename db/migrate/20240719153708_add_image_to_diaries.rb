class AddImageToDiaries < ActiveRecord::Migration[7.1]
  def change
    add_column :diaries, :image, :string
  end
end
