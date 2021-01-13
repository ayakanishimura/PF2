class AddStartTimeToArticles < ActiveRecord::Migration[5.2]
  def change
    add_column :articles, :start_time, :datetime
  end
end
