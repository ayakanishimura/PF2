class ChangeDataNameToGenre < ActiveRecord::Migration[5.2]
  def change
    change_column :genres, :name, :integer
  end
end
