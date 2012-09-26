class AddRelationshipIdsToVods < ActiveRecord::Migration
  def change
    add_column :vods, :movie_id, :integer

    add_column :vods, :platform_id, :integer

  end
end
