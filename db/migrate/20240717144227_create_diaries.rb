class CreateDiaries < ActiveRecord::Migration[7.1]
  def change
    create_table :diaries do |t|
      t.text :content
      t.date :date
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
