# API INTRO

go to Github Classroom and invite self https://classroom.github.com/a/s9Cg7Cih
We are going to make an API that will take in data and serve data to our front end.

```ruby
$ rails new cat-tinder-backend-instructors -d postgresql -T
$ cd cat-tinder-backend
$ rails db:create
#bundle is a package manager for rails.  Let's install some dependencies.
$ bundle add rspec-rails
$ rails generate rspec:install

$ git add remote


$ git checkout -b main
$ git add .
$ git commit -m 'initial commit'
$ git push origin main
$ rails server
```

```ruby
$ rails generate resource Cat name:string age:integer enjoys:text image:text
$ rails db:migrate

# Check the migration/schema in rails db

$ rspec spec
# just to make sure things didn't break -->
```

# Rails Seed

Bring in data in an array

when you made the wildlife tracker you had to insert all of the data manually. with seeds you can get up and running with starter data quickly. Why use seeds? Aside from just the quick start, the content of the development database is part of the code base instead of on each developer's computer. This way by running a command after we clone a project, the database can be easily populated.

```ruby
cats = [
  {
    name: 'Kevin',
    age: 9,
    enjoys: 'Talking to the dogs walking by',
    image: 'https://c2.peakpx.com/wallpaper/591/784/17/cat-animal-pet-cat-face-head-black-wallpaper-preview.jpg'
  },
  {
    name: 'Geppetto',
    age: 14,
    enjoys: 'Being outside in the sun',
    image: 'https://www.publicdomainpictures.net/pictures/200000/nahled/ragdoll-cat-with-green-eyes-14766395657Vf.jpg'
  },
  {
    name: 'Priscilla',
    age: 8,
    enjoys: 'Wanting attention from humans. Only humans.',
    image: 'https://petkeen.com/wp-content/uploads/2021/04/Blue-norwegian-forest-cat_Elisa-Putti_Shutterstock-760x507.jpg'
  },
  {
    name: 'Tuesday',
    age: 20,
    enjoys: 'Looking into your soul with my giant eyes.',
    image: 'https://c2.peakpx.com/wallpaper/296/908/856/cat-big-eyes-female-animal-fur-wallpaper-preview.jpg'
  }
]

# loop over the array of cat objects and for each object, use the create method to add to the database
cats.each do |cat|
  Cat.create cat
  # as a developer check we can print the cat objects that are added when we run rails db:seed
  puts "creating cat #{cat}"
end
```

$ rails db:seed

$ rails c
$ Cat.all

Keep this in mind: Each time we run rails db:seed we will end up adding the mock data to our database. SO if we ran it three times we would have 3 of each cat in our database.

## Trouble Shooting

$ rails db:drop
$ rails db:create
$ rails db:migrate
$ rails db:seed

# API CORS

before we continue with cors we are going to want to make our lives a bit easier by bypassing some built in security in rails. normally this before_action command would verify that information was coming from within the rails app and would not allow us to pass in information from outside. We want to skip that before_action.

### app/controllers/application_controller.rb

```ruby
class ApplicationController < ActionController::Base
  skip_before_action :verify_authenticity_token
end
```

Cross-Origin Resource Sharing (CORS) is an HTTP-header based mechanism that allows a server to indicate any origins (domain, scheme, or port)
other than its own from which a browser should permit loading of resources.

<!-- place this at the bottom of the GEMFILE -->

`gem 'rack-cors', :require => 'rack/cors'`

 <!-- config/initializers create file named cors.rb -->

```ruby
Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins '*'  # <- change this to allow requests from any domain while in development.

    resource '*',
      headers: :any,
      methods: [:get, :post, :put, :patch, :delete, :options, :head]
  end
end
```

`$ bundle install`

When you take your app to production, you'll want to change the wildcard \* to the URL that your frontend app is served from.
