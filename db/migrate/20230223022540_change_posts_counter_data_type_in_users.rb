class ChangePostsCounterDataTypeInUsers < ActiveRecord::Migration[7.0]
  def up
    change_column :users, :posts_counter, :integer, default: 0, using: 'posts_counter::integer'
  end

  def down
    change_column :users, :posts_counter, :string
  end
end