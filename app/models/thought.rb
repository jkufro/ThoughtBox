class Thought < ApplicationRecord
  belongs_to :next_thought, class_name: 'Thought', optional: true
  belongs_to :previous_thought, class_name: 'Thought', optional: true

  MOODS = ['positive', 'neutral', 'negative']

  scope :by_created_at, -> { order('created_at DESC') }

  validates :mood, inclusion: { in: MOODS }
end
