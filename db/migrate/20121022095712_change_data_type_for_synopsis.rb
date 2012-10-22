class ChangeDataTypeForSynopsis < ActiveRecord::Migration
  def up
    change_table :movies do |t|
         t.change :synopsis, :text, :limit => 1000000000000
    end
  end

  def down
    change_table :movies do |t|
          t.change :synopsis, :string
    end
  end
end
