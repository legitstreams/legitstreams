class ChangeDataTypeForTitle < ActiveRecord::Migration
  def up
    change_table :movies do |t|
         t.change :title, :text
    end
  end

  def down
    change_table :movies do |t|
          t.change :title, :string
    end
  end
end
