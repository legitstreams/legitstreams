class CreateVods < ActiveRecord::Migration
  def change
    create_table :vods do |t|
      t.string :movie_url

      t.timestamps
    end
  end
end
