class Thought < ApplicationRecord
  MOODS = ['positive', 'neutral', 'negative']

  validates :mood, :inclusion=> { :in => MOODS }
end
