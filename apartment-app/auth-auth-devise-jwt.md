# Apartment App

This week we will be building another decoupled application called Apartment App. We will again be using Trello for project management, but this time we will be working in teams of 3. There will be a little different dynamic when it comes to our project management. Each team will be responsible for communicating and determining who is working on what tasks. While it is up to you on how you want to work in your teams, many groups find that mobbing is helpful to get through some of the tougher tasks. The key is to communicate blockers and progress with your team.

Like Cat Tinder, we will start with the backend, add the front end later, and then connect them.

The majority of this lecture will be adding configurations - and there are a lot of them. It's a lengthy process, but everything is lined out in the syllabus. We'll be introducing a few new concepts that are very important to understand. I strongly encourage you not to code along. Instead, work on grasping what each step is doing.

### Setup

- $ `rails new apartment-app-backend -d postgresql -T`
- $ `cd apartment-app-backend`
- $ `rails db:create`
- $ `bundle add rspec-rails`
- $ `rails generate rspec:install`

### GitHub

- `git checkout -b main`
- `git remote add origin https://github.com/learn-academy-2023-echo/apartment-app-backend-<your-team>.git`
- `git add .`
- `git commit -m ':tada: initial commit'`
- `git push origin main`
- Ask for branch protection
- $ `rails s`

## Authorization v Authentication

Most web applications we interact with require you to login for certain features on their website. This brings us to Authorization and Authentication.
These are two independent yet interconnected concepts

- Authentication allows you to provide valid credentials, i.e. username and password. Think of logging-in as authenticating the user.
- Authorization - defines what data the authenticated user can access.

## Devise

- Devise is a Ruby gem. What is a gem?
- libraries or packages of code that we can bring into our applications.
- Devise is a very popular gem, used in many applications, which means it has a lot of community support. Go to
- Devise gives us the ability to create a user in our application. The user can log into an account and have special access to certain parts of your application. This brings us to two important concepts, authorization and authentication.

### Devise Install

- $ `bundle add devise`
- $ `rails generate devise:install`
- $ `rails generate devise User`
- $ `rails db:migrate`

Show the class the backend files related to User (schema/model/etc.)

## Updating the backend to use JWT with Devise

What's great about Devise is that it can handle both authorization and authentication.

- So we can authenticate a user, which means it gives us login pages where a user can create an account or login to an account.

Now, since we have a decoupled application, we will need to verify that a person is who they are on the backend. We also need the frontend to know that a user is logged in and is now authorized to access specific features in the application. To pass this information, we will be using JWT.

### What is JWT and Why Use it?

- JWT stands for JSON Web Token, and it is an open standard for securely transmitting information between frontend and backend as a JSON object. We mainly use JWT in authorization.

- When a user logs in, the server generates a JWT, signs it using a secret key, and sends it back to the client.
- The client (frontend) stores the token in the browser using localStorage. localStorage is a JavaScript property that allows us to save key-value pairs in the browser. Now all subsequent API requests will include the token.

## Steps for backend connection.

Do this very methodically. Make sure everything goes in the right file/folder. To implement JWT with Devise, we need to install two more gems:

### 1. Add the following to your Gemfile: <br>

`gem 'devise-jwt'` <br>
`gem 'rack-cors'`
then run `bundle`

### 2. Update your CORS file

CORS stands for Cross-Origin Resource Sharing. Our React frontend and Rails backend applications are running on two different servers. We have to tell the Rails app that (while in development) it is okay to accept requests from any outside domain.

Along with allowing requests, we will need to send a JWT token to the frontend through the headers.

`config/initializers/cors.rb`

```ruby
Rails.application.config.middleware.insert_before 0, Rack::Cors do
 allow do
   origins 'http://localhost:3001'
   resource '*',
   headers: ["Authorization"],
   expose: ["Authorization"],
   methods: [:get, :post, :put, :patch, :delete, :options, :head],
   max_age: 600
 end
end
```

### 4. Additional Devise Setup

We will also need to ensure that devise does not use flash messages since this is an API.

`api/config/initializers/devise.rb`

```ruby
config.navigational_formats = []
```

### 5. Additional Controllers and Routes for Devise

We need access to some additional files that devise has available to handle sign ups and logins.

```bash
 $ rails g devise:controllers users -c registrations sessions
```

We will replace the code in the registrations controller and sessions controller:
`app/controllers/users/registrations_controller.rb`

```ruby
class Users::RegistrationsController < Devise::RegistrationsController
  respond_to :json
  def create
    build_resource(sign_up_params)
    resource.save
    sign_in(resource_name, resource)
    render json: resource
  end
end
```

`app/controllers/users/sessions_controller.rb`

```ruby
# app/users/sessions_controller.rb
class Users::SessionsController < Devise::SessionsController
  respond_to :json
  private
  def respond_with(resource, _opts = {})
    render json: resource
  end
  def respond_to_on_destroy
    render json: { message: "Logged out." }
  end
end
```

Then we need to update the devise routes: <br>
`config/routes.rb`

```ruby
Rails.application.routes.draw do
  devise_for :users,
    path: '',
    path_names: {
      sign_in: 'login',
      sign_out: 'logout',
      registration: 'signup'
    },
    controllers: {
      sessions: 'users/sessions',
      registrations: 'users/registrations'
    }
end
```

### 6. Create and Generate JWT token and Hide

We need a secret key to create a JWT token. Generate one with this command: $`bundle exec rake secret`

Rails stores secrets in the credentials.yml.enc and uses the master.key, both found in the config folder.

To add your secret key, use the following command:
`$ EDITOR="code --wait" bin/rails credentials:edit`

Now you can assign the secret to a key jwt_secret_key at the bottom of this file.
`jwt_secret_key: <newly-created secret key>`
\*\* do not use the angle brackets, nor do you need the key to be in quotes.

CTRL + c will encrypt and save the file.

### 7. Configure Devise-JWT

in your devise.rb file add the following - anywhere is fine, I added to bottom of my file.
`config/initializers/devise.rb`

```ruby
# api/config/initializers/devise.rb
 config.jwt do |jwt|
   jwt.secret = Rails.application.credentials.jwt_secret_key
   jwt.dispatch_requests = [
     ['POST', %r{^/login$}],
   ]
   jwt.revocation_requests = [
     ['DELETE', %r{^/logout$}]
   ]
   jwt.expiration_time = 5.minutes.to_i
 end
```

### 8. Revocation

While there are several ways to revoke a token with devise-jwt, we are going to use the DenyList.

1.  Create denylist table:

```bash
$ rails generate model jwt_denylist
```

2.  Update the migration file with the following code:

```ruby
def change
 create_table :jwt_denylist do |t|
   t.string :jti, null: false
   t.datetime :exp, null: false
 end
 add_index :jwt_denylist, :jti
end
```

3. `$ rails db:migrate`

4. Update the user model so that it uses JWT tokens. You will be removing part of the devise attributes. So it should look like this (plus your association)
   `app/models/user.rb`

```ruby
class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :jwt_authenticatable, jwt_revocation_strategy: JwtDenylist
end
```

...and we're done! Phew! Run `rails s` to make sure you aren't getting errors.

## Apartments

Ok, we are configured. Let's think about what data we need in our app. Apartments will have a street, unit number, city, state, square footage, price, number of bedrooms, number of bathrooms, if pets are allowed, and of course, and image.
But there is also a relationship between users and apartments, right? An apartment can only be created by a valid, logged in user and a user can create as many apartments as they want. So what would the Active Record associations be? User has_many Apartments, Apartments belongs_to User. Therefore we will need a foregn key of user_id to the belongs_to table.

user.rb
has_many :apartments

apartment.rb
belongs_to :user

- $ `rails g resource Apartment street:string unit:string city:string state:string square_footage:integer price:string bedrooms:integer bathrooms:float pets:string image:text user_id:integer`
  -$ `rails db:migrate`

### Seeds

User instance in the database, we need a unique username, password, and password confirmation. When this information is successfully submitted to the database, a new instance of User will be created.

Seed data has to align with the relationship of our User and Apartment models. Before we have apartments, we must have users.

Devise provides us with some built-in validations. For example, every user in the database must have a unique email. To ensure our seeded user data is made correctly, we can use the .first_or_create Active Record method. Using the .where method, we first query for all emails that match a particular user in the database. The .where method will return an array of all matches. The .first_or_create method checks whether the first instance in the array is nil or not. If the value is nil, then no user exists. A nil value will trigger the .create method which requires password and password confirmation keys with matching password values.

```ruby
user1 = User.where(email: "test1@example.com").first_or_create(password: "password", password_confirmation: "password")
user2 = User.where(email: "test2@example.com").first_or_create(password: "password", password_confirmation: "password")


user1_apartments = [
  {
    street: "ABC Sesame Street",
    unit: "20",
    city: "Sesame",
    state: "ISLE",
    square_footage: 2000,
    price: 15000,
    bedrooms: 5,
    bathrooms: 3,
    pets: "puppets only",
    image: "https://upload.wikimedia.org/wikipedia/commons/0/00/Sesame_Street_buildings_%28193090534%29.jpg"
  }
]

user2_apartments = [
  {
      street: "Walaby Way",
      unit: "42",
      city: "Sydney",
      state: "Australia",
      square_footage: 2000,
      price: 25000,
      bedrooms: 3,
      bathrooms: 2,
      pets: "fish",
      image: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSWBSF2x6QbX697RXfV7WdOtqCxF9glLOlF_37xL7pvvea_bWK8JkWHu1llBVz8k9LmFbY&usqp=CAU"
  }
]

user1_apartments.each do |apartment|
    user1.apartments.create(apartment)
    p "created: #{apartment}"
end

user2_apartments.each do |apartment|
    user2.apartments.create(apartment)
    p "created: #{apartment}"
end
```

- $ `rails db:seed`

## The End.
