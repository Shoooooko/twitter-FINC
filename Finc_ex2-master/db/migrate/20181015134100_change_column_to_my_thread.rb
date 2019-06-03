class ChangeColumnToMyThread < ActiveRecord::Migration[5.2]
  def change
    change_column :my_threads, :title, :string, null: false
    change_column :my_threads, :body, :text, null: false
  end
end
