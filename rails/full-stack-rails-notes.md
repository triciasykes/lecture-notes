# Full-Stack Rails Notes
https://gitmoji.dev/

# Setup using Github Classroom link
* Note on github/rails and the repo.  Github classroom link will provide you with an empty repo.  You will see this view <show view> - there are no files, just steps you can take to link your local to a remote.  The first thing I want to do is create the rails app on my desktop

 - $  rails new full-stack-rails -d postgresql -T
 - $  cd full-stack-rails
 - $  rails db:create

  There are no files, just steps you can take to link your local to a remote. We want git to manage our project. Rails comes with git already, 
 - $ ls -a
 This shows all the hidden folders and you'll see git is there. So to stop things from getting confusing and messy, we want git to manage everything at one level.  Think about if you created a repo in a repo. Yeah, we don't want that.  No nested projects/no conflict. So we are going to tell rails that git will manage by single repo.

 - $  git remote add origin <<https://github.com/learn-academy-2022-foxtrot/full-stack-kevin.git>>
 - $  git branch  <!-- no main, so create one -->
 - $  git checkout -b main
 - $  git status <!-- normally don't want to use all because it's really easy to make mistakes>
 - $  git add .
 - $  git status
 - $  git commit -m 'initial commit'
 - $  git push origin main
 - $  bundle add rspec-rails
 - $  rails g rspec:install
 
 - $  rails g model Book name:string read:string
 - $  rails db:migrate
 - $  rails g controller Book
 make sure everything is working
 - $ rails server
 - navigate to localhost:3000

 Now add data:
 - $ rails c
 >> Book.all ===> empty array
 >> Book.create(name:'Brave New World', read:'yes')
 >> Book.create(name:'Hunger Games', read:'yes')
 >> Book.create(name:'Shantaram', read:'no')


README.md
- Add index and description:
 
### Index
- a list of all the things
- get request
- read CRUD action
- controller method 
- route 
- view 

  in BookController
```ruby
  def index
  #active record query to see all the books in the db, stored in instance variable
    @books = Book.all
  end
  ```
  Routes:
  get 'books' => 'book#index'

  View:
  in book folder
  make file `index.html.erb`
  add <%= @books %>
  
  localhost:3000/books

```html   
<h2>My Reading Tracker</h2>
  <ul>
    <% @books.each do |book| %>
      <li><%= book.name %></li>
    <% end %>
  </ul>
``` 
Then back to Routes
add:  root 'book#index'


Update Index
- a list of all the things
- get request
- read CRUD action
- controller method 
  - holds the active record query
- route 
  - defining the url and calling the index method
- view 
  - iterated over AR array
  - added HTML for markup structure
  - displays info in a meaningful way

  ### Show
  - displays one item
  - get request
  - read CRUD action
  - controller action
  - route
  - view

  in BookController
  1. How to find specific instance in Active Record query (rails c)?
```ruby
  def show
    #params gives us access to the url which will have an id
    @book = Book.find(params[:id])
  end
```
in Routes
 params is the hash, when we pass the symbol :id, we get the value of the id.  This is what is passed into the active record query.  
 
   get 'books/:id' => 'book#show'

in Views
 make file show.html.erb
 ```html
 <h3><%= @book.name %></h3>
<br>
<h4>Have I read the book?: <%= @book.read %></h4>
```   
 Only problem now is that we have to manipulate the url (do we ever do this in real life?)
 We will use the link_to
 We want the routes to be in charge of navigation
 We want to create an alias, or specify a name for the route using the :as optio. Let's create an alias on the show route. We can then reference it like a variable and it will take us to the show page.  We use the as: 'book' as our alias.

 `  get 'books/:id' => 'book#show', as: 'book'`

 then in index.html.erb, make book.name clickable. link_to takes 2 arguments, what you're linking and the path.  Because it's a route, we add _path to the end of the alias.
 But we need to pass the id for the route, so we can pass (book) to alias to ref the id.
<li>
  <%= link_to book.name, book_path(book) %>
</li>

Let's also add an alias for the index, so we can return to the index page.  Let rails be in charge of the things it wants to be incharge of.  Internal navigation.
in Routes
get 'books' => 'book#index', as: 'books'

```html
<h5> <%= link_to 'Back to Books', books_path %></h5>
```

Update Show
Show
- displays one thing
- get request
- read CRUD action
- controller method (done)
- route (done)
  - Parameters: {"id"=>"1"} from the rails server in terminal
- view (done)
  - add route aliases
  - add links to show and back to home

**Commit Code at this point - 'added index and show actions'**
**checkout new branch***
**Add files and folders individually**
**push, merge, delete branch remote/local**

### New

- displays a form
- get request
- read CRUD action
- controller method
- route
- view

In Controller
  def new
    @book = Book.new
  end

in Routes
#this is not a variable, this is exactly how the url will look
 get 'books/new' => 'books#new'

In view
new.html.erb 
**go to guides for form help!**

https://guides.rubyonrails.org/form_helpers.html

```ruby
<%= form_with do |form| %>
  Form contents
<% end %>
```

Use Generic Search Form

```ruby
<%= form_with model: @book do |form| %>
  <%= form.label :name %>
  <%= form.text_field :name %>
  <%= form.label :read %>
  <%= form.text_field :read %>
  <%= form.submit "Add Book" %>
<% end %>
```
Routes need to be in a specific order. Routes read top to bottom.  Putting more specific routes higher up means fewer errors when not requiring a param.
 see picture

Make form nicer:

<h3>Add a New Book</h3>
<%= form_with model: @book do |form| %>
  <%= form.label :name %>
  <%= form.text_field :name %>
  <br><br>
  <%= form.label :read %>
  <%= form.text_field :read %>
  <br><br>
  <%= form.submit "Add Book" %>
<% end %>


Now in Routes, add alias
get 'books/new' => 'book#new', as: 'new_book'

Now UPDATE NEW
- displays a form
- get request
- read CRUD action
- controller method (done)
- route (done)
  - reorder the routes
- view (done)
  - Rails forms
  - added links to the form and back home

### Create
- adds content from the form to the db
- post request
- create CRUD action
- controller method 
- route 
- view 

In controller:
def create
  @book = Book.create
end

Think about allowing users to add content - we want to be careful and put some limits on what access users have to create a book. This protection is called strong params. We start do this by creating a method `book_params` - makes sure the only table users interact with is book, and only contribute to columns 'name' and 'read'. Shouldn't be able to add id, or add columns that don't already exist. 

In controller: 
#strong params
def book_params
  params.require(:book).permit(:name, :read)
end

We're going to let strong params actually take the data and create it. So we pass in the method call of strong params in the create method.  Strong params are the controller's level of protection - on the request side of things. Only permitting the name and read because we don't want any other data going in and out of this database. 

def create
  @book = Book.create(book_params)
end


in Routes:  making a post request!

post 'books' => 'book#create'

Lets see if it works!

Check terminal server for the post action log.

UX is not very good.  We don't have anything to show the user that they created a new book.
Let's use a redirect to take back to the index page that will show the updated index with new book.

Go back to Controller
def create
  @book = Book.create(book_params)
    if @book.valid?
      redirect_to books_path  #_path indicates it's a route, if want to ref as a route alias. Definied as an alias, if reference anywhere else, you must use _path
    end
end
 
Private - puts a limit on where method can be called.  Can only be called inside this scope of this class.  Can only called within the Book Class.  Any method I write needs to be above this private keyword

**add private above strong params**


### DESTROY
-controller
-routes
-view

Controller: 
 def destroy
   @book = Book.find(params[:id])
   @book.destroy
end

Routes:
delete 'books/:id' => 'book#destroy', as: 'delete_book'
Although delete doesn't have a view, We do need an alias because we need to call the route to delete the content


<p><%= button_to 'Remove Book', 
  delete_book_path %></p>
  
By default, most browser actions fall into get or post.  If doing a patch or delete action will need to indicate that you are making a different kind of request. 
<p><%= button_to 'Remove Book', 
  delete_book_path, method: 'delete' %></p>

NOTE: Show delete and edit all need the params because we need the id  


BAD UX, let's do same thing we did for create. If destroyed, redirect back to index page

if @book.destroy
  redirect_to books_path
end


### EDIT

def edit
    @book = Book.find(params[:id])
end

Routes:
get 'books/:id/edit' => 'book#edit, as: edit_book

put this on show page as a link.

<p>
  <%= link_to 'Edit Book',
    edit_book_path(@book) %>
</p>

VIEW:

<h2> Edit Book</h2>
# steal form datat from edit

<%= form_with model: @book, method: :patch do |form| %>
  <%= form.label :name %>
  <%= form.text_field :name %>
  <br><br>
  <%= form.label :read %>
  <%= form.text_field :read %>
  <br><br>
  <%= form.submit "Update Book" %>
<% end %>

<p>
  <%= link_to 'Back to Home', books_path %>
</p>

## Update
-controller

def update
  @book = Book.find(params[:id])
  @book.update(book_params)
end

- Routes
Patch request
patch 'books/:id' => 'book#update'


<!-- completed controller -->
```ruby
app/controllers/book_controller.rb

class BookController < ApplicationController

  def index
    @books = Book.all
  end

  def show
    #params gives us access to the url which will have an id
    @book = Book.find(params[:id])
  end

  def new
    @book = Book.new
  end

  def create
    @book = Book.create(book_params)
      if @book.valid?
        redirect_to books_path
      end
  end

  def destroy
    @book = Book.find(params[:id])
    if @book.destroy
      redirect_to books_path
    end
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    @book.update(book_params)
    if @book.valid?
      redirect_to book_path(@book)
    end
  end

  #strong params
  def book_params
    params.require(:book).permit(:name,:read)
  end
end
```
<!-- Completed Routes -->
```ruby
Rails.application.routes.draw do
  get 'books' => 'book#index', as: 'books'
  get 'books/new' => 'book#new', as: 'new_book'
  get 'books/:id' => 'book#show', as: 'book'
  post 'books' => 'book#create'
  get 'books/:id/edit' => 'book#edit', as: 'edit_book'
  patch 'books/:id' => 'book#update'
  delete 'books/:id' => 'book#destroy', as: 'delete_book'
  root "book#index"
end
```
<!-- Completed Index -->
<h2>My Reading Tracker</h2>
<ul>
<% @books.each do |book| %>
  <li>
    <%= link_to book.name, book_path(book) %>
  </li>
<% end %>
</ul>
<br>
<p><%= link_to 'Add a New Book', new_book_path %></p>

<!-- Completed Show -->
<h3><%= @book.name %></h3>
<br>
<h4>Have I read the book?: <%= @book.read %></h4>
<p>
  <%= link_to 'Back to Home', books_path %>
</p>
<br>

<p><%= link_to 'Edit Book', 
  edit_book_path(@book) %> </p>
  <br>
<p><%= button_to 'Remove Book', 
  delete_book_path, method: :delete %> </p>

<!-- completed New -->
<h3>Add a New Book</h3>
<%= form_with model: @book do |form| %>
  <%= form.label :name %>
  <%= form.text_field :name %>
  <br><br>
  <%= form.label :read %>
  <%= form.text_field :read %>
  <br><br>
  <%= form.submit "Add Book" %>
<% end %>

<p>
  <%= link_to 'Back to Home', books_path %>
</p>

<!-- Completed Edit -->
<h2>Edit Book</h2>
<%= form_with model: @book, method: :patch do |form| %>
  <%= form.label :name %>
  <%= form.text_field :name %>
  <br><br>
  <%= form.label :read %>
  <%= form.text_field :read %>
  <br><br>
  <%= form.submit "Edit Book" %>
<% end %>

<p>
  <%= link_to 'Back to Home', books_path %>
</p>


