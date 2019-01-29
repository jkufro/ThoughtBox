class Thought < ApplicationRecord
    MOODS = ['happy', 'neutral', 'sad']

    validates :mood, :inclusion=> { :in => MOODS }
end
