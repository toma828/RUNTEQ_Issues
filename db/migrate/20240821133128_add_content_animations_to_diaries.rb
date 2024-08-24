class AddContentAnimationsToDiaries < ActiveRecord::Migration[7.1]
  def change
    add_column :diaries, :content_animations, :string
  end
end
