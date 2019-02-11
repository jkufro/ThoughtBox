class AddNextThoughtIdToThoughts < ActiveRecord::Migration[5.2]
  def change
    add_column :thoughts, :next_thought_id, :integer
    remove_column :thoughts, :thought_id, :integer
  end
end
