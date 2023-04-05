# Ruby Conditionals and Methods

## Overview
- Conditional statements create logic through evaluations that return a Boolean value
- There is only one outcome per conditional statement
- Ruby allows two-way interactions through the terminal
- Ruby methods are custom logic that can take inputs and will always produce outputs

## Process
- Ensure you are in the cohort-lecture-examples repo
- Ensure your local is up to date and there are no stale branches
- create a new branch `ruby-conditionals-and-methods`
- create a Ruby file `ruby-conditionals-and-methods.rb`
- Run the file with `ruby <filename>`

## Additional Notes and Goals
- The `puts` or `p` should always be on the invocation not on the inner working of the method

## Major Takeaways
- Using p and puts
- Defining executable code blocks
- Syntax of Ruby conditionals - `if`, `elsif`, `else`, `end`
- Syntax of string interpolation `"#{}"`
- Every `def` needs a corresponding `end`
- Ruby has an *** implicit return ***
- Methods must be invoked

### Lecture - Conditionals
Creating decision structures is an important fundamental in performing any kind of code logic. We've seen this in JS and now we'll look at the similairities and differences in creating descision structures in Ruby.

Luckily, if we understand the fundamental concepts, the small changes in syntax are very manageable. To rview, a decision structure - also called a decision tree or an if statement - is a series of evaluations. Each evaluation wil return a Boolean value of true or false. If a statement is true, the corresponding code will execute and the statement will be finished. If the statement is false, no code will execute and the program will move to the next decision.

#### Ruby Conditionals
Ruby is a language that is designed to be very human readable. So there are much fewer curly braces than we see in JS. In replacement of the curly braces, Ruby depends on indentation. As a Ruby developer, all indentations should consist of TWO spaces. Indentation always matters, but it really matter in Ruby.
- `if` is a keyword in Ruby
- `if` takes an evaluation that will return a Boolean value
- `end` is a keyword in Ruby
- `end` closes the code block

```ruby
if 7 + 8 == 15
  p 'the answer is 15'
end
```
- `else` is a keyword in Ruby
- Just like in JS, the else statement is a catchall and does not take an evaluation

```ruby
if 7 + 8 == 16
  p 'is the answer 16?`
else 
  p 'no conditions in this statement evaluated to true'
end
```

- `elsif` is a keyword in Ruby
- `elsif` also takes an evaluation that will return a Boolean value
- There can be as many `elsif` statements as needed
```ruby
if 7 + 8 == 16
  p 'is the answer 16?'
elsif 7 + 8 == 17
  p 'is the answer 17?'  
elsif 7 + 8 == 18
  p 'is the answer 18?' 
elsif 7 + 8 == 15
  p 'is the answer 15?'
else
  p 'no conditions in this statement evaluated to true'
end
```
#### User Input
Ruby has a method that will allow two-way interaction in the terminal. We are used to seeing the output of our code. In Ruby we can use the terminal to facilitate user inputs. This makes conditional statements a little more fun.
```ruby
my_name = 'Trish'

if my_name == 'Trish
  p 'Hi there Trish'
else
  p 'Hey there, #{my_name}'
end
```
We cna change the value of the variable to see different outcomes.  We can actually assign our variable through the terminal
- `gets` is a method that will stop the execution of the program and wait for you to type something and hit enter
- We can save whatever the user types into a variable
- `p` the variable and look at the output

```ruby
gets
my_name = gets
p my_name
```
- notice the output has extra characters
- The `\n` is a character for a line break, we don't typically see these characters, but the computer sees them
- We need to remove the line break characters so they aren't included in the variable
- Of course, Ruby has a method that will remove any additional characters at the end of a string - my fave `.chomp`
- Note `gets` will always return a string

```ruby
p 'what is your name?'
your_name = gets.chomp
p "Thank you for being a polyglot, #{your_name}"

my_name = gets.chomp
p my_name

if my_name == 'Trish
  p 'Hi there Trish'
else
  p 'Hey there, #{my_name}'
end
```

## Lecture - Methods
- Everything in Ruby is an object which is an instance of a class. this means that all functions are technically methods
- Talking about custom methods means the same thing we talk about when we say "creating a function to do this thing" in JS.
- Just like in JS we need to be able to define custom methods that take an input and produce and output
- When you create a method in Ruby, you define it
  - `def` is a keyword in Ruby short for "define"
  - Every `def` needs a corresponding `end`

## Method Syntax
- start with `def`
- Give the method a name. Naming convention is snake_case
- end the method with `end`.  (end is like the closing curly bracket in JS)
- Indentation is super important because we are not relying on curly brackets to show us the start and end of a code block, so indentation is going to help us see if something is missing.
- The most simple method we can create will just return a line of code

```ruby
def greeter
  'Hello Bravo!'
end
```
*** In terminal: `$ ruby filename.rb` ***
- this won't do anything because the method is not currently invoked
- Try again by invoking function
- to call a ruby method, just reference it's name and add a p before it so it prints to the console.
- The `puts` or `p` should always be on the invocation not the inner working of the method. Remember `puts` will always output a string, where as `p` will print out the raw output (better to use p for debugging). 

### Looking at how to build a method
1. define the method `def greeter`
                     `end`
  - best to add the `end` right away so you don't forget
2. Add the logic in between  `'Hello Bravo!'`
3. invoke the method `p greeter`
*** NOTE: 
- there isn't a `return`. In JS if we didn't use the keyword `return`, we would get back `undefined`. 
- While Ruby does have a keyword `return`, we don't have to use it.
- Ruby will automatically return the last line of every method unless we say otherwise. This is called an *** implicit return ***

### Methods with Arguments
- The last example is pretty basic. We want to utilize the benefits of creating a method for it's reusability
- We can refactor this to take in a parameter and use some string interpolation to greet the person
- Interestingly, we do not need parenthesis on either the argument or parameter
```ruby
def greeter name
  "Hello #{name}!"
end
p greeter "Mark"
```
### Multiple Arguments
- While we don't need parenthesis for a parameter, it is definitely good practice to use parentheses if there are multiple parameters. 
- Let's create a method that takes in two numbers
- return the result of multiplying the numbers

```ruby
def multiply(num1, num2)
  num1 * num2
end
p multiply(3, 5)
```
- Ruby will be happy with either way, however - using parentheses cn make your code more readable such as wehn passing multiple arguments
- remember methods are reusable so we can call them over and over and over again.

```ruby
def multiply(num1, num2)
  num1 * num2
end
p multiply(3, 5)
p multiply(6, 7)
p multiply(4, 9)
p multiply(2, 4)
```
#### Methods with Conditional Logic
Often we need to add more logic into a method. Let's create a problem where we create a mehtod that decides which number is greater
- Every `def` needs an `end`
- Every `if` needs an `end`
- Two different ends means two different execution layers of code
- This is were indentation is so important so we know which end is going to which scope

```ruby
def greater_num(num1, num2)
  if num1 > num2
    "#{num1} is greater"
  elsif num1 < num2
    "#{num2} is greater"
  else
    "#{num1} and #{num2} are equal"
  end
end
p greater_num(36, 49)
p greater_num(15, 8)
p greater_num(42, 42)
```
#### getting User Input
As a final step, let's get user input from the terminal rather than from our program

We can create a method that asks a user for their name and age. Then it will give a customized answer to whether or not the user is old enough to vote.  We've done this before in JS.

```ruby
puts 'Enter your Name'
user_name = gets.chomp
p user_name
puts 'Enter your Age'
p user_age

def can_you_vote(name, age)
  if age >= 18
    "Hi #{name}! #{age} is old enough to vote"
  else
    "Hi #{name}! #{age} is not old enough to vote"
  end
end

p can_you_vote(user_name, user_age)
```
Notice we get an error `>=': comparison of String with 18 failed (ArgumentError)`
So we can use another ruby method to turn a string into an integer:  `.to_i`

```ruby
p user_age.class
user_age = gets.chomp.to_it
```
### Review
- What is def?
- What is implicit return?
- Where does the p and the puts belong in the method?
- What data type will the gets method return?
