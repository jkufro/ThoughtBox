class ThoughtsController < ApplicationController
  def index
    @thoughts = Thought.all
  end
end
