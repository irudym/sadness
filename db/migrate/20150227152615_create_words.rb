class CreateWords < ActiveRecord::Migration
  def change
    create_table :words do |t|
      t.string :word
      t.string :sadness
      t.string :integer

      t.timestamps null: false
    end
  end
end
