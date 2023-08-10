# Ruby Classes and Objects Lecture Notes

## Intro
Remember everything in Ruby is an object, which means everything in Ruby is an instance of a class.  You can't call methods or use dot notation on classes. A class is not a thing, it is a recipe, a blueprint.

<!-- in irb type:  8.class 
                  =>  Integer -->
                  
We interact with an instance of a class. There are of course built-in classes in Ruby like we've seen.  But of course we can create custom classes.

To define a class we use the keyword `class`.  Remember class names always use PascalCase. The scope of the class is defined by the keyword end.
What's a favorite streaming service of yours?
- have class choose service, ie AppleTv, Hulu, Max, Netflix, etc. Type that instead of 'Netflix'
  
```ruby
class Netflix 
end
```
If we run this file, we will get nothing.  It's a class - but if we instantiate a class by typing
`p Netflix.new`

we get something that looks like this: `#<Netflix:0x000000013d998200>`
this is a new instance of the class - it is an object.

We can invoke this new method multiple times
and we'll see that we get unique objects.

We can set this to a variable, which will then hold the object.
Ask class for name of a show
```ruby
class_example = Netflix.new
p class_example
```
We have a class that we can create shows. But it's not very interesting. A class needs something to do.
 
There are two things we want to be able to do when working with classes.
1. we want to hold data in our class
2. we want to retrieve data that we've set

In ruby, these are called getting and setting.

#### Setters
Let's start with setting. lets create a method that takes in a parameter and assigns that value to a varialbe. When creating a variable that belongs to a class there is a special syntax. In JavasScript it was the keyword "this"; in Ruby it is an instance variable.

```ruby
  class Netflix
    def set_show_data(title)
    @title = title
    end
  end

 # First object
 class_example = Netflix.new
 class_example.set_show_data('Title Here')
 p class_example

 #second object
 another_class_example = Netflix.new
 another_class_example.set_show_info('Title Here')
 p another_class_example
 ```
Now I can make as many instances as I want each will be a unique object
  
A setter method can have as many instance variables as needed.
```ruby
class Netflix
  def set_show_data(title, actor)
    @title = title
    @actor = actor
  end
end

class_example = Netflix.new
class_example.set_show_data('Title Here', 'Actor Name')
p class_example
```
### Getters
We can see the variables belong to the class, but how do we get those values back? Right now, I can get the object with that info as we saw.  But what if we just want the title? we need getter methods

```ruby
class Netflix
  def set_show_data(title, actor)
    @title = title
    @actor = actor
  end

  def get_title
    @title
  end

  def get_actor
    @actor
  end
end

class_example = Netflix.new
class_example.set_show_data('Title Here', 'Actor Name')
p class_example.get_title
p class_example.get_actor
```

#### Initializer
Setter methods are very useful, but in this example when we instantiate the class (.new) there is no title nor actor.  There is actually a special kind of setter method that is called by the `.new` method.  It is called the *** initializer ***  

```ruby
class Netflix
  def initialize(title, actor)
    @title = title
    @actor = actor
  end

  def get_title
    @title
  end

  def get_actor
    @actor
  end
end

class_example = Netflix.new('Title Here', 'Actor Name')
p class_example.get_title
p class_example.get_actor
```

#### Putting it All Together
the initialize method is acting as the initial setter and there are getters to return info. Now that the initialize is handling the creation of the instance variables, we can use setter methods to modify the values.
```ruby
class Netflix
  def initialize(title, actor)
    @title = title
    @actor = actor
    @watched = false
  end

  def get_title
    @title
  end

  def get_actor
    @actor
  end

  def has_watched
    @wateched = true
  end

  def show_data
    if @watched
      "You have wateched the show #{@title} starring #{@actor}."
    else
      "You have not watched the show #{@title} starring #{@actor}."
    end
  end
end

class_example = Netflix.new('Title Here', 'Actor Name')
p class_example.show_data
class_example.has_watched
p class_example.show_data
```
#### Attribute Accessor
So far we have covered the fundamental concepts needed to understand Ruby classes. Now, we can dig into additional Ruby methods to refactor the code. Ruby offers a method called `attr_accessor` whose job is to make more methods. By passing a symbol of our instance variable to the `attr_accessor` method we get two methods created in return - a getter for that variable and a setter for that variable.

Adding `attr_accessor` allows the removal of some of the getter and setter methods
```ruby
class Netflix
  attr_accessor :title, :actor, :watched
  
  def initialize(title, actor)
    @title = title
    @actor = actor
    @watched = false
  end
  # def get_title
  #   @title
  # end

  # def get_actor
  #   @actor
  # end

  # def has_watched
  #   @wateched = true
  # end
  def show_data
    if @watched
      "You have wateched the show #{@title} starring #{@actor}."
    else
      "You have not watched the show #{@title} starring #{@actor}."
    end
  end
end

class_example = Netflix.new('Title Here', 'Actor Name')
p class_example.title
class_example.title = 'New Title Here'
p class_example.title
p class_example.show_data
class_example.watched = true
p class_example.show_data





