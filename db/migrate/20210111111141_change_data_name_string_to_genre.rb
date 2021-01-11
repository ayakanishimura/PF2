class ChangeDataNameStringToGenre < ActiveRecord::Migration[5.2]
  def change
    change_column :genres, :name, :string
  end
end
