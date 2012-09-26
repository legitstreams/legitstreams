class RemoveImageFromMovies < ActiveRecord::Migration
  def up
    remove_column :movies, :image
      end

  def down
    add_column :movies, :image, :string
  end
end
