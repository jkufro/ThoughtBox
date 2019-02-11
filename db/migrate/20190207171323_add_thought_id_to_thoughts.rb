class AddThoughtIdToThoughts < ActiveRecord::Migration[5.2]
  def change
    add_column :thoughts, :thought_id, :integer
  end
end
