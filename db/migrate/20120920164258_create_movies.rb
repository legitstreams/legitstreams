class CreateMovies < ActiveRecord::Migration
  def change
    create_table :movies do |t|
      t.string :title
      t.integer :year
      t.string :language
      t.string :image
      t.string :actor1
      t.string :actor2
      t.string :director
      t.string :synopsis

      t.timestamps
    end
  end
end
