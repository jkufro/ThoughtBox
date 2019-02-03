class Thought < ApplicationRecord
  MOODS = ['positive', 'neutral', 'negative']

  scope :by_created_at, -> { order('created_at DESC') }

  validates :mood, inclusion: { in: MOODS }
end
