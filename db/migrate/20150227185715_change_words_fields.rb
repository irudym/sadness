class ChangeWordsFields < ActiveRecord::Migration
  def change
    change_table :words do |t|
      t.change :sadness, :integer
      t.remove :integer
    end
  end
end
