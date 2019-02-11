class ThoughtsController < ApplicationController
  require 'net/http'

  @@origin_index = 0

  def index
  end

  def show
    origin_thoughts = Thought.all.origin.by_created_at
    puts(@@origin_index)

    if origin_thoughts.size > 0
      origin = origin_thoughts.first.created_at > 15.seconds.ago ? origin_thoughts.first : origin_thoughts[@@origin_index % origin_thoughts.size]
      @thought_chain = get_chain(origin)
    else
      @thought_chain = [Thought.new(content: 'No thoughts created yet', mood: 'neutral')]
    end

    if ENV['PARTICLE_ID'] && ENV['PARTICLE_TOKEN']
      uri = URI("https://api.particle.io/v1/devices/#{ENV['PARTICLE_ID']}/play?access_token=#{ENV['PARTICLE_TOKEN']}")
      Net::HTTP.post(uri, {}.to_json, "Content-Type" => "application/json")
    end

    @@origin_index += 1
    render json: @thought_chain
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

    def get_chain(origin, chain = [])
      return chain if origin.nil?

      chain << origin
      get_chain(origin.next_thought, chain)
    end
end
