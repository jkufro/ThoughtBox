namespace :db do
  desc "Erase and fill database"
  # creating a rake task within db namespace called 'populate'
  # executing 'rake db:populate' will cause this script to run
  task populate: :environment do
    # Drop the old db and recreate from scratch
    Rake::Task['db:drop'].invoke
    Rake::Task['db:create'].invoke

    # Invoke rake db:migrate
    Rake::Task['db:migrate'].invoke
    Rake::Task['db:test:prepare'].invoke

    # Docs at: http://faker.rubyforge.org/rdoc/
    require 'faker'
    include ThoughtsHelper

    # Create all thoughts
    thoughts = []
    100.times do
      this_mood = Thought::MOODS.sample
      content = ''
      if this_mood == 'positive'
        content = ThoughtsHelper.positive_thought
      elsif this_mood == 'negative'
        content = ThoughtsHelper.negative_thought
      else  # neutral
        content = ThoughtsHelper.neutral_thought
      end
      thought = Thought.new(content: content, mood: this_mood)
      thought.save
      thoughts << thought
      sleep 0.1
    end
    puts 'generated all thoughts'
  end
end
