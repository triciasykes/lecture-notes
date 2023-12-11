# Rails Generate Resource/Postman/Intro to Wildlife Tracker Notes

As we know, rails follow the MVC architecture and we've been closely following this structure for the past week. You've all made a fullstack app!
It is very common to build the backend, or the Model and controllers in rails and then use a different framework for the View. As we all know by now, we'll be using this approach for the rest of our projects. So for the next day, we are going to work on building our own API, which means we will only build the model and controller parts of Rails.

API - Application Programming Interface - responsible for transmitting info across the internet as JSON. API are how computers interact with other computers.

JSON - Javascript Object Notation - is a data structure supported by most programming languages and modeled off of Javascript. We will look at this shortly, but it will look familiar.

So let's get started

Each person will get a github classroom link where we will each build a Wildlife Tracker API. We will follow the procedure we used yesterday and I will again walk through that now. First let's accept the assignment

- Again, we are given an empty repo
- Create a new Rails app on our desktop
  - `$ rails new rails-api -d postgresql -T`
  - `$ cd rails-api`
  - `$ rails db:create`
- Now you will need to connect my app to my GitHub repo
- `$ git add remote add origin http//:github.com<<rest of link>>`
- `$ git checkout -b main`
- git status, git add . commit, push to main

- Then we add Rspec
- `$ bundle add rspec-rails`
- `$ rails generate rspec:install`
- Check the server
  - `$ rails s`

Since you are all building a tracker, I will build a student tracker that has student name and the cohort they are in.

We have used several rails generate commands to create our models and controllers. Today we are going to use a fabulous command that is going to create files for our model, controller, views, routes, and their respective rspec files as well.

The syntax is very similar to our generate model command. We provide the model name, the columns with their datatypes

`$ rails g resource Student name:string cohort:string`
Let's look at all the files it gives us!
Since we are making an API which have no need for views, we're just going to delete that folder

- `$ rm -r app/view/students`

Almost everything we just created we're pretty familiar with from making them individually. But there is one thing added that we haven't seen before and that is the resources route. Let's check it out

- in vscode go to config/routes.rb
  But what does it mean? This one line of code sets all of our RESTful routes for us! And I will show you, but first we must run db:migrate
- `$ rails db:migrate`

To see all the routes it created we can run a simple informational command

- `$ rails routes -Expand`

### Create Some Data

Since we have our model setup, our controller created, and the routes already written - let's add some data

- `$ rails c`
- `$ student.create(name:'Andre', cohort:'Hotel')`
- `$ student.create(name:'Bao', cohort:'Echo')`
- `$ student.create(name:'Nikki', cohort:'Bravo')`
- `$ student.create(name:'Josh', cohort:'Alpha')`
- `$ Student.all`

### RESTful Routes

Ok, so let's think about our restful routes.

- Index: gets all the things
- New: form
- Show: shows one thing
- Update: updates existing data on one thing
- Create: adds new instance to db
- Edit: form
- Destroy: deletes instance from db

Since we're not including view, we don't need forms!

- Index
- Show
- Create
- Update
- Destroy

### Index

```ruby
  def index
    students = Student.all
    render json:students
  end
```

because we have no view, we don't need the instance variable - just a regular variable. While I pretty confident this method will work, how can I be sure? I don't have a view. Enter backend developers friend Postman.

### Postman

Postman is a beautful GUI that allows us to display the data we want to interact with. See it as a view for our API.

- you many need to log in or create account
- Create new
- HTTP Request

Notice at the top we have our HTTP verbs, a place to enter our url and a lovely send button
Make sure your server is running!

- URL: localhost:3000/students
- set it to JSON
- hit send!
- We can aslo see the call in our terminal

### Show

```ruby
def show
  student = Student.find(params[:id)])
  if student.valid?
    render json: student
  else
    render json: student.errors
  end
end
```

Postman:

- URL: localhost/3000/1
- Send shows us the one instance

### Create

```ruby
def create
 student = Student.create(student_params)
  if student.valid?
    render json: student
  else
    render json: student.errors
  end
end

private
# strong params
def student_params
  params.require(:student).permit(:name, :cohort)
end
```

Postman:

- Change request to POST
- URL: localhost/students
- Select:
  - Body
  - Raw
  - Text --> JSON
- Setup Params:

```ruby
{
  "name": "Graham",
  "cohort": "Echo"
}
```

When I see HTML instead of JSON, it means there's a problem. I can click on the Preview to see the error.

Let's checkout the syllabus for more information here:
For static page Rails applications, a check is made to assure that the data submitted to the controller originates from the same website. In most single page applications that consume an API we don't use this feature and need to disable it. Add the following code:

```ruby
app/controllers/application_controller.rb

`skip_before_action :verify_authenticity_token`
```

We can disable this while in development so we can interact with Postman.

### Update

```ruby
def update
  student = Student.find(params[:id])
  student.update(student_params)
  if student.valid?
    render json: student
  else
    render json: student.errors
  end
end
```

Postman:

- URL: localhost:3000/students/2
- Set to PATCH request
- Update params

{
"name": "Luis",
"cohort": "Delta"
}

### Destroy

```ruby
def destroy
  student = Student.find(params[:id])
  if student.destroy
  # in postman, we can see some kind of response so we can render student. Later for UX you don't  want to show them this.
      render json: student
  else
    render json: student.errors
  end
end
```

Postman:

- Change to Delete
- URL: localhost:3000/students/4
- we can see the student who just removed pops up
- To double check, let get all the students
  cdri
