# 👩‍💻 Setup

- Clone or pull most updated version of backend repo
- `bundle`
- `git checkout -b api-endpoints`
- `rails db:create`
- `rails db:migrate`
- `rails db:seed`
- `rails s`
- Check Trello!!

---

# 🧑🏻‍🏫 Lecture

### Intro

- The endpoints are going to cover the CRUD actions.
- An endpoint is one end of a communication channel. When an API interacts with another system, the touchpoints of this communication are considered endpoints.
- For APIs, an endpoint can include a URL of a server or service.
  - To get all cats - create index endpoint
  - Endpoint is where the request turns into the response
  - End result of request response cycle in an API is the JSON package being delivered
  - Routes get us the right controller method → controller method performs right action to interact with API

### Routes

- Go to `config/routes` and see that we have `resources :cats`
  - This came from our generate command - gives us all the RESTful routes for cats
  - run `rails routes`
    - Shows RESTful routes

### Endpoints

- Stub controller methods:
  - **Stub**: piece of code used to stand in for some other programming functionality.
  - May simulate the behavior of existing code or be a temporary substitute for yet-to-be-developed code.

```ruby
class CatsController < ApplicationController

  def index
  end

  def create
  end

  def update
  end

  def destroy
  end

end
```

- This gives us methods that we can test, otherwise our tests would come back undefined while practicing TDD.

### Index Route

- Returns all cats in the cats table
- Test Driven Development:
  - Add test to the `cats_request_spec.rb` file:

```ruby
require 'rails_helper'

RSpec.describe "Cats", type: :request do
  describe "GET /index" do
    it "gets a list of cats" do
			Cat.create(
			        name: 'Felix',
			        age: 2,
			        enjoys: 'Walks in the park',
			        image: 'https://images.unsplash.com/photo-1529778873920-4da4926a72c2?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1036&q=80'
			      )
			      # create an active record query to the database

			      # Make a request to the specific endpoint
			      get '/cats'

			      # Specify the data interaction, response to be in the format of JSON.  Convert the response to JSON and assign it to a variable called cat.
			      cat = JSON.parse(response.body)

			      # We are checking that we have a successful request or a status of 200 and that we are returning the accurate amount of data.
			      expect(response).to have_http_status(200)
			      expect(cat.length).to eq 1
			    end
			  end
			end
```

- `rspec spec/cats_request_spec.rb`

ERROR: Good fail since there is no code in the controller.

- Write the controller code to make it pass:

```ruby
def index
  cats = Cat.all
  render json: cats
end
```

### Create

- Create a test for the create method:
  - Define params structure with cat_params.
    - Essentially resembles the hash structure when we are directly putting this into the console.
    - Added into the request, ran through strong params and passed into the create method.
    - The param will take the cat object.

```ruby
describe "POST /create" do
  it "creates a cat" do
    # The params we are going to send with the request
    cat_params = {
      cat: {
        name: 'Buster',
        age: 4,
        enjoys: 'Meow Mix, and plenty of sunshine.',
        image: 'https://images.unsplash.com/photo-1529778873920-4da4926a72c2?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1036&q=80'
      }
    }

    # Send the request to the server and pass params which are cat_params
    post '/cats', params: cat_params

    # Assure that we get a success back
    expect(response).to have_http_status(200)

    # Look up the cat we expect to be created in the db
    cat = Cat.first

    # Assure that the created cat has the correct attributes
    expect(cat.name).to eq 'Buster'
    expect(new_cat.age).to eq 4
    expect(new_cat.enjoys).to eq 'Meow Mix, and plenty of sunshine.'
  end
end
```

ERROR: Good failure since we have no code in the controller

- Add code to create controller method:

```ruby
def create
    # Create a new cat
    cat = Cat.create(cat_params)
    render json: cat
  end

  # Handle strong parameters, so we are secure
  private
  def cat_params
    #              Table        Columns
    #              v                v
    params.require(:cat).permit(:name, :age, :enjoys, :image)
  end
```

### _Optional: Update_

- Create a test for the update method:

```ruby

 describe "PATCH /update" do
    it 'updates a cat' do

      # create the cat
    cat_params = {
      cat: {
        name: 'Buster',
        age: 4,
        enjoys: 'Meow Mix, and plenty of sunshine.',
        image: 'https://images.unsplash.com/photo-1529778873920-4da4926a72c2?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1036&q=80'
      }
    }
      post '/cats', params: cat_params
      cat = Cat.first

      # update the cat
    updated_cat_params = {
      cat: {
        name: 'Buster',
        age: 5,
        enjoys: 'Meow Mix, and plenty of sunshine.',
        image: 'https://images.unsplash.com/photo-1529778873920-4da4926a72c2?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1036&q=80'
      }
    }
        #   While cat is the only item in our databse we dont know its id. It's id will be dynamic to each time we run our tests. so we will have to use some string interporlation to call on it's id and pass it the updated params
#   p cat
      patch "/cats/#{cat.id}", params: updated_cat_params

   # cat = Cat.first
      updated_cat = Cat.find(cat.id)
      expect(response).to have_http_status(200)
    # expect(cat.age).to eq 5
      expect(updated_cat.age).to eq 5
    end
  end
```

- Add code to update method:

```ruby
def update
    cat = Cat.find(params[:id])
    cat.update(cat_params)
    render json: cat
end
```

### _Optional: Delete_

- Create a test for the delete method:

```ruby
describe "DELETE /destroy" do
    it 'deletes a cat' do
      # create the cat
      cat_params = {
        cat: {
          name: 'Buster',
          age: 4,
          enjoys: 'Meow Mix, and plenty of sunshine.',
          image: 'https://images.unsplash.com/photo-1529778873920-4da4926a72c2?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1036&q=80'
        }
      }
      post '/cats', params: cat_params
      cat = Cat.first
      delete "/cats/#{cat.id}"
      expect(response).to have_http_status(200)
      cats = Cat.all
      expect(cats).to be_empty
    end
  end

```

- Add code to destroy method:

```ruby

def destroy
    cat = Cat.find(params[:id])
    cat.destroy
    render json: cat
  end
```

---

# 🔤 Recap of Vocabulary

- • **API endpoints:** the touch point of communication within the API when an external request is made
- **Stub**: piece of code used to stand in for some other programming functionality.

# 🕵️ Recap of Major Takeaways

- Practice TDD when writing out controller methods
- Tests need mock data to interact with requiring the creation of a cat and when necessary params to create cat
- Tests are checking a successful request response cycle

---

# 🏃 Next Steps

- Push lecture notes to GitHub
- Merge and delete branch
- Walkthrough challenges
- Remind the students of the appropriate naming conventions for their branch and file
- Post pairs in Slack
- Open breakout rooms with ability for participants to choose their room
