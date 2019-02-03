# ThoughtBox
[![Build Status](https://travis-ci.org/jkufro/ThoughtBox.svg?branch=master)](https://travis-ci.org/jkufro/ThoughtBox)

**Ruby Version:** `2.5.1`

**Rails Version:** `5.2.1`

## Description
How might memory become augmented in the future? What if we could externalize our own thoughts automatically? How many times would we prevent thinking up a great idea in the moment, only to forget exactly what it was later? A device implanted into the brain could read thoughts, and externalize them to a personal device, server, or anything else. This project is meant to be provocative in that it will explore what privacy concerns may arise when our in-the-moment thoughts are externalized via simulation. Will the benefits outweigh the concerns? We must ask ourselves if we could truly accept this kind of technology in society before it’s too late. To simulate the effect of “thought-reading”, I propose to create the ThoughtBox. This device will be a simple box with a display on it; when physically interacted with by a user it will generate a randomized thought and display it for all to see. Thoughts may be positive, neutral, or negative – it’s all up to chance.

## Deployment
### Heroku Deployment
This project is automatically deployed to heroku at [https://jkufro-thought-box.heroku.com/](https://jkufro-thought-box.heroku.com/)

### Deploying locally
```
bundle install
rails db:populate
rails server
```

Development and Test environments use SQLite3, Production uses Postgresql

## Running Tests
```
rubocop
find app/views/ -name *.haml | xargs bin/bundle exec haml --check
rails test
```
