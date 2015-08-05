class MakeWordUniqInWords < ActiveRecord::Migration
  def change
    change_table :words do |t|
      t.change :word, :string, :unique => true
    end
  end
end
