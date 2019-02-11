class AddPreviousThoughtIdToThoughts < ActiveRecord::Migration[5.2]
  def change
    add_column :thoughts, :previous_thought_id, :integer
  end
end
