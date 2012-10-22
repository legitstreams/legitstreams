class ChangeDataTypeForSynopsis < ActiveRecord::Migration
  def up
    change_table :movies do |t|
         t.change :synopsis, :text
    end
  end

  def down
    change_table :movies do |t|
          t.change :synopsis, :string
    end
  end
end
