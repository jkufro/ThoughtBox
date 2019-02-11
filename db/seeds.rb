# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).

require 'faker'
def chain_thoughts(thoughts_list)
  return thoughts_list.first if thoughts_list.size <= 1

  last_thought = nil
  thoughts_list.each do |t|
    if last_thought.nil?
      last_thought = t
      next
    end

    last_thought.next_thought = t
    t.previous_thought = last_thought

    last_thought = t
  end

  thoughts_list.each do |t|
    t.save
  end

  return thoughts_list
end

# Remove all existing entries since Heroku doesn't allow dropping tables
Thought.delete_all

# negotiating
chain_thoughts([Thought.new(content: "I'm so excited that I'm going to get a new car today!", mood: 'neutral'),
                Thought.new(content: "I'm able to pay $6,000 but I really would like to spend $4,000", mood: 'neutral'),
                Thought.new(content: "This one is nice! And exactly $4,000!", mood: 'neutral'),
                Thought.new(content: "Why is this salesman pushing the $6,000 car so much? It has more features but are they really worth it?", mood: 'neutral'),
                Thought.new(content: "I regret not buying the cheaper car.", mood: 'neutral'),
                Thought.new(content: "It's like the salesman was in my head... manipulating me.", mood: 'neutral')])

# remembering
chain_thoughts([Thought.new(content: "I need to remember to record the game on the DVR when I get home.", mood: 'neutral'),
                Thought.new(content: "Pats versus Rams. This will be good!", mood: 'neutral'),
                Thought.new(content: "This reminds me of #{Faker::Name.first_name} and how we used to watch together.", mood: 'neutral'),
                Thought.new(content: "I can't watch anymore. It brings back too many memories...", mood: 'neutral')])

# surveillance
chain_thoughts([Thought.new(content: "Could the Oceania war with Eastasia be fake?", mood: 'neutral'),
                Thought.new(content: "Does the Oceania government really care about its people?", mood: 'neutral'),
                Thought.new(content: "Who could be at the door at this hour?", mood: 'neutral'),
                Thought.new(content: "Oh no... it's the thought police.", mood: 'neutral')])

# reaching out to an old friend
# chain_thoughts([Thought.new(content: "I miss #{Faker::Name.first_name}. I should call them later.", mood: 'neutral'),
#                 Thought.new(content: "", mood: 'neutral'),
#                 Thought.new(content: "reaching out3", mood: 'neutral')])

# blank mind
chain_thoughts([Thought.new(content: "...", mood: 'neutral'),
                Thought.new(content: "What do tigers dream of when they take a little tiger snooze?", mood: 'neutral'),
                Thought.new(content: "...", mood: 'neutral'),
                Thought.new(content: "Was I just thinking of something important?", mood: 'neutral'),
                Thought.new(content: "I just checked the time a few seconds ago but I already forgot what it was.", mood: 'neutral'),
                Thought.new(content: "I'm bored.", mood: 'neutral')])

# life fulfillment, what if's?
chain_thoughts([Thought.new(content: "I wonder what my life be like I'm older...", mood: 'neutral'),
                Thought.new(content: "Would my life be different if I had gone to #{Faker::Educator.university} instead?", mood: 'neutral'),
                Thought.new(content: "What if I had dropped out and become a professional #{Faker::Music.instrument} player like I wanted?", mood: 'neutral'),
                Thought.new(content: "Will I ever get to be the person I want to?", mood: 'neutral'),
                Thought.new(content: "Will people remember me?", mood: 'neutral')])

# Add positive thoughts
# Thought.create(content: "I miss #{Faker::Name.first_name} so much. I should call them later.", mood: 'positive')
# Thought.create(content: "I'm so happy I got that interview!", mood: 'positive')
# Thought.create(content: "I want to write my own cookbook.", mood: 'positive')
# Thought.create(content: "The weather is so nice today!", mood: 'positive')
# Thought.create(content: "I'm so blessed to have such good friends.", mood: 'positive')
# Thought.create(content: "My friends are my power!", mood: 'positive')
# Thought.create(content: "That #{Faker::Food.dish} I had was the best I ever tasted.", mood: 'positive')
# Thought.create(content: "I'm having so much fun!", mood: 'positive')
# Thought.create(content: "Wow, the Particle API is so cool!", mood: 'positive')
# # Thought.create(content: "", mood: 'positive')

# # Add neutral thoughts
# Thought.create(content: "...", mood: 'neutral')
# Thought.create(content: "I wonder if #{Faker::Name.first_name} knows I'm staring at them...", mood: 'neutral')
# Thought.create(content: "Does anyone else understand what professor #{Faker::Name.last_name} says?", mood: 'neutral')
# Thought.create(content: "Would my life be different if I had gone to #{Faker::Educator.university} instead?", mood: 'neutral')
# Thought.create(content: "I should drop out and become a professional #{Faker::Music.instrument} player.", mood: 'neutral')
# Thought.create(content: "I can't forget to get #{Faker::Food.ingredient} at the store on the way home.", mood: 'neutral')
# Thought.create(content: "I wish my roomate would clean up after themself.", mood: 'neutral')
# Thought.create(content: "I just checked the time a few seconds ago but I already forgot.", mood: 'neutral')
# Thought.create(content: "Why do I feel like I was supposed to do something today.", mood: 'neutral')
# Thought.create(content: "Remember to bring the proposal documents to work tomorrow.", mood: 'neutral')
# Thought.create(content: "Would the world end if Friends was removed from Netflix?", mood: 'neutral')
# Thought.create(content: "Remember to record the game tonight on the DVR.", mood: 'neutral')
# Thought.create(content: "I hope #{Faker::Name.first_name} gets me concert tickets for my birthday.", mood: 'neutral')
# Thought.create(content: "What should I do for Valentines Day?", mood: 'neutral')
# Thought.create(content: "I wonder what my life be like I'm older.", mood: 'neutral')
# Thought.create(content: "Should I be concerned about exporting my thoughts?", mood: 'neutral')
# # Thought.create(content: "", mood: 'neutral')

# # Add negative thoughts
# Thought.create(content: "Ugh, #{Faker::Name.first_name} is so annoying", mood: 'negative')
# Thought.create(content: "I never should have pushed #{Faker::Name.first_name} away", mood: 'negative')
# Thought.create(content: "That #{Faker::Food.dish} I ate really messed up my stomach...", mood: 'negative')
# Thought.create(content: "I'd rather eat #{Faker::Measurement.weight} of #{Faker::Food.ingredient.pluralize} than sit here for another minute.", mood: 'negative')
# Thought.create(content: "I can't let #{Faker::Name.first_name} figure out that I'm really bluffing.", mood: 'negative')
# Thought.create(content: "I'm so hungry I can't concentrate.", mood: 'negative')
# Thought.create(content: "I'd really pay $100 for it, but I'll try $75 first.", mood: 'negative')
# Thought.create(content: "I'm bored.", mood: 'negative')
# Thought.create(content: "Why can't I do anything right?", mood: 'negative')
# Thought.create(content: "Why is thinking up thoughts so difficult?", mood: 'negative')
# Thought.create(content: "I don't think #{Faker::Name.first_name} is even listening to me.", mood: 'negative')
# Thought.create(content: "I want to go home.", mood: 'negative')
# Thought.create(content: "I wish I could have gone to the concert", mood: 'negative')
# Thought.create(content: "They think I'm leaving tomorrow, but my flight actually leaves in a few hours.", mood: 'negative')
# # Thought.create(content: "", mood: 'negative')
