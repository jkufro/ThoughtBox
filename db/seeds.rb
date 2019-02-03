# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).

Thought.delete_all
Thought.create(content: 'this is a test thought', mood: 'positive')
