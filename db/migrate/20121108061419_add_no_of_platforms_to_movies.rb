class AddNoOfPlatformsToMovies < ActiveRecord::Migration
  def change
    add_column :movies, :no_of_platforms, :integer

  end
end
