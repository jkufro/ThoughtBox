class CreateThoughts < ActiveRecord::Migration[5.2]
  def change
    create_table :thoughts do |t|
      t.string :content
      t.string :mood

      t.timestamps
    end
  end
end
