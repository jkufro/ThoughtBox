class ThoughtsController < ApplicationController
  def index
  end

  def show
    thoughts = Thought.all.by_created_at
    if thoughts.size > 0
      @thought = thoughts.first.created_at > 15.seconds.ago ? thoughts.first : thoughts.sample
    else
      @thought = Thought.new(content: 'No thoughts created yet', mood: 'neutral')
    end
    render json: @thought
  end

  def new
    @thought = Thought.new()
  end

  def create
    @thought = Thought.new(thought_params)
    if @thought.save
      redirect_to :home
    else
      render 'new'
    end
  end

  private
    def thought_params
      params.require(:thought).permit(:content, :mood)
    end
end
