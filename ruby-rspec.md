# RSPEC LECTURE NOTES

## Overview
- Test-driven development is the process of creating tests first, seeing the test fail, then creating the code to make the test pass
- RSpec is a testing language for Ruby
- RSpec stands for Ruby specification or specs
- RSpec is installed via RubyGems which is a package manager for Ruby
- Tests should only look at the output of the code, not the inner magic

## Process
- Ensure you are in the cohort-lecture-examples repo
- Ensure your local is up to date and there are no stale branches
- Create a new branch
- Create a folder called `ruby-rspec`
- Create a Ruby file called `rspec_book.rb`
- Create a Ruby spec file called `rspec_spec.rb`
- Run tests with `rspec rspec_spec.rb`

## Additional Notes/Goals
 - Looking at similarities between Jest and RSpec

## Takeaways
- Practicing TDD
- RubyGems is package manager for Ruby, gem is the package of code
- RSpec syntax
- Difference between the expect statements with {} and ()

## Lecture
RSpec is a Domain Specific Language which is a language that has been specialized for a particular task. In this case RSpec is specialized for testing Ruby code.

Who remembers what TDD stands for: test-driven development, is a developer philosophy of writing tests(or specs, short for specifications) first and then creating the code that will make the tests pass. TDD is closely associated with the phrase `red-green-refactor`. Which means we will write our tests first and see them fail(red), then write the code to make it pass(green), then if we need to do any refactor or make any edits on the code, we can do so confidently.

### RSpec Installs and Setup
Let's start by creating a class for Book.  Book is going to be a template from which we can create many instances of books. The Book class will have both data and behavior.  A book can have a title, and author, and pages, which are all data. We can also read a book which will change the current page we're on. Since this is an action (or behavior) we will call them methods.

We are going to have two files. One is going to have the Ruby code and one is going to have the tests. 

- Google:  https://rubygems.org/gems/rspec/versions/3.4.0
- $`gem install rspec`
- in rspec_spec.rb:
   `require 'rspec'
   `require_relative 'rspec_book'
- Add `describe` block with a do/end block
- add `it` block with do/end block
- Add expect statement that will run the new method and expect the creation of a class
- Run the test with `rspec rspec_spec.rb`
- Look at the failing test

```ruby
require 'rspec'
require_relative 'rspec_book'

describe 'Book' do
  it 'has to be real' do
    expect{ Book.new }.to_not raise_error
  end
end
```
Now let's write the code that will make the test pass

```ruby
class Book
end
```
run the test again

### Now let's test for Book Should Have a Title:
Now we want to be able to have our Book class have some static data
- Add an additional `it` block to the test
- Create an instance of Book
- Call a setter method to give Book a title
- Expect the outcome
- This expect statement has parentheses because the outcome is data, curly braces are used when the outcome is behavior
- Run the test `rspec rspec_spec.rb`
- look at the failing test

```ruby
it 'has a title' do
  my_book = Book.new
  my_book.title = 'Brave New World'
  expect(my_book.title).to be_a String
  expect(my_book.title).to eq 'Brave New World'
end
```
Run the test

- Add the code that will make the test pass
- Can use an initializer to create the variable on instantiation
- `attr_accessor` will give us getter and setter methods

```ruby
rspec_book.rb

class Book
  attr_accessor :title
  def initialize
    @title = title
  end
end
```
### A Book Should Have an Author

if there is no author we can have a default value of anonymous
- Add an additional `it` block 
- Create an instance of Book
- Book should have default author of anonymous
- Expect the outcome
- run `rspec rspec_spec.rb`
- Look at failing test
```ruby
# rspec_spec.rb
 it 'has an author' do
    my_book = Book.new
    expect(my_book.author).to eq 'anonymous'
    expect(my_book.author).to be_a String
    my_book.author = 'Aldous Huxley'
    expect(my_book.author).to eq 'Aldous Huxley'
  end
  ```
  - Now add the code that will make the test pass
  ```ruby
  # rspec_book.rb
  class Book
    attr_accessor :title, :author
    def initialize author='anonymous'
      @title = title
      @author = author
    end
  end
  ```
  ### Book Should have Current Page
  A new instance of a book will always start with the page at 1
  - Add additional `it` block
  - Create instance of Book
  - Expect the outcome
  - This expect has parentheses becuase the outcome is data
  - run `rspec_spec.rb`
  - Look at failing test
  ```ruby
  it 'starts on page 1' do
    my_book = Book.new
    expect(my_book.page).to eq 1
    expect(my_book.page).to be_a Integer
  end
  ```
  Add the code

 ```ruby
 class Book
  attr_accessor :title, :author, :page
  def initialize author='anonymous'
    @title = title
    @author = author
    @page = 1
  end
end
```
### Reading the Book 
We can add a method that will move the page number forward. We will be looking at behavior so we need different expect statements in the test.

- what kind of syntax do we use in expect statements that output static data? parentheses
- for behavior, we use {}
- I mentioned a couple common matchers earlier, but we're going to need something else to help us count pages, so let's look at an rspec docs. https://rspec.info/documentation/
- The `change` method seems to be what we need
- Add an additional `it` block
- Create an instance of Book
- expect the outcome
- This expect statement has curly braces because the outcome is a behavior
- `rspec rspec_spec.rb`
- Look at failing test
```ruby
# rspec_spec.rb
it 'can read pages' do
  expect{ my_book.read 5}.to change{ my_book.page }.from(1).to(6)
end
```
Add the code
```ruby
# rspec_book.rb

class Book
  attr_accessor :title, :author, :page
  def initialize author='anonymous'
    @title = title
    @author = author
    @page = 1
  end

  def read pages_read
    @page += pages_read
  end
end 
```

### Adding a Library
Let's look at creating a collection of books. We can make another class that will handle our collection.
- create another file called `rspec_library.rb`
- Need to import into the testing file 
- Create describe block
- add `it` block
- Expect the outcome using {} because the outcome is a behavior
-`rspec rspec_spec.rb`
- Look at failing test
```ruby
#rspec_spec.rb
require 'rspec'
require_relative 'rspec_book.rb'
require_relative 'rspec_libary.rb'

# ...the previous code ...
describe 'Library' do

  it 'has to be real' do
    expect{ Library.new }.to_not raise_error
  end
end
```
### Create a collection of Books
We can create a collection that is of the data type Array
- Add `it` statement
- create instance of Library
- expect the outcome using parenthese because the outcome is data
- Run the tests with `rspec rspec_spec.rb`
- Look at the failing test
```ruby
# rspec_spec.rb

it 'has an array of books' do
  my_library = Library.new
  expect(my_library.book_collection).to be_a Array
end
```
### Add Books
Now we can add books to our books array
- In current `it` block
- create instance of Library
- create 2-3 instances of Book
- Expect the outcome using parentheses since the outcome is data
- `rspec rspec_spec.rb`
- Look at the failing test
```ruby
# rspec_spec.rb
# add this to the current it statement
it 'has an array of books' do
  my_library = Library.new
  brave = Book.new
  razor = Book.new
  my_library.add_books brave
  my_library.add_books razor
  expect(my_library.book_collection).not_to be_empty
  expect(my_library.book_collection).to contain_exactly(brave, razor)
end
```
Add the code

```ruby
# rspec_library.rb

class Library
  attr_accessor :book_collection
  def initialize
    @book_collection = []
  end

  def read_books book
    @book_collection << book
  end
end
```
## Review
- What is RSpec?
- What is TDD?
- What imports are required to run RSpec?
- In which file do the imports belong?
- What is the difference between expect statements with curly braces vs parentheses?









