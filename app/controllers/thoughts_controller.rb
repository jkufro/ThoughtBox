class ThoughtsController < ApplicationController
  def index
  end

  def show
    thoughts = Thought.all.by_created_at
    if thoughts.size > 0
      @thought = thoughts.first.created_at > 1.minute.ago ? thoughts.first : thoughts.sample
    else
      @thought = Thought.new(content: 'No thoughts created yet', mood: 'neutral')
    end
    render json: @thought
  end
end
