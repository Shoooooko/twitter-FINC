class CreateProfiles < ActiveRecord::Migration[5.2]
  def change
    create_table :profiles do |t|
      t.string :nickname, null: false
      t.integer :age
      t.string :picture

      t.timestamps
    end
  end
end
