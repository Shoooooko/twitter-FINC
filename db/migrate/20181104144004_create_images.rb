class CreateImages < ActiveRecord::Migration[5.2]
  def change
    create_table :images do |t|
      t.references :posts, foreign_key: true
      t.string :picture

      t.timestamps
    end
  end
end
