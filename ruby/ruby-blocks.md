# Ruby Blocks and Iterables

Today we are going to discuss Ruby blocks and iterables. Who can define iteration:

- process of repeating an action until a condition is met.

So we are going to talk about different types of iteration in Ruby.

Let's start with `while`

- needs a starting point and end point
- then a condition that starts as true and eventually become false

```ruby
  num = 1  #remember we don't need a variable declaration like var or let

  while num <= 10
    p num
    num += 1
  end
```

show what happends if we don't increment num ===> endless loop, ctrl + c to stop

## Methods

There are a lot of ruby methods for iteration
methods can take an anonymous function -> this is called a BLOCK
Blocks can be defined in 2 ways:

- using keywords `do` and `end` or with {} curly brackets
- general style guidelines say to use do/end block when more than 1 line. {} for one-liner

### Times

The first method we are going to discuss is times. it executes a block a certain number of times. it attaches to the number you want to use followed by the block. The key to times is that it must know how many times to run.

```ruby
8.times do
p 'hello world'
end

#we will get the same result if we structure this as a one liner:

8.times { p 'hello world' }
```

We can also run times on a variable:

```ruby
num = 10
num.times do
  p 'hello world'
end
```

### Each

- works on a list of items, so needs an array in order to run. This is like forEach in JS. It looks at the length of the array and automatically runs the number of times equal to the number of elements.

```ruby
nums = [3,4,5,6,7]
nums.each do |value|  # we pass the paramater using the pipes
  p value
end
```

- As with JS, this allows more complexity because we can access and manipulate each value.

```ruby
nums = [3,4,5,6,7]
nums.each do |value|
  p value * 5
end
```

Note: Ruby isn't as picky as JS when it comes to what methods work on which data types. It just looks to see if it has the ability to say be reversed or changed to uppercase. If it does, ruby will change it.

`str = "string"`
`p str.reverse`

### Ranges

A range is a list of values. You give it a start and end separated by 2 dots and ruby fills the content inbetween the 2 points. a ranges values are inclusive

try printing
`p 1..10`

we just get the range definitiion, but we can iterate by setting the range to a variable.

```ruby
range = 1..10

range.each do |value|
  p value
end
```

ranges can be as big as you need.  
They can also be LETTERS!

```ruby
letter_range = 'a'..'g'
letter_range.each do |v|
p v
end
```

AND we can also put the range in an array using `to_a`
`p letter_range.to_a`

So cool.

### Map

Now our old friend map!
iterator that returns an array of the same length of the data structure you're acting on

```ruby
nums = 1..10
mapped = nums.map do | value |
  value * 3
end
p mapped
```

its a useful tood to get an array that's storing data. But let's do some cooler!

```ruby
mapped = nums.map do |value|
  if value % 2 === 0
    'even'
  else
    value
  end
end
p mapped
```

how much cleaner and easier is that than JS?? BUT WAIT ---- THIS IS RUBY....COULD THERE BE A METHOD? WHY YES THERE'S A METHOD CALLED EVEN? AND ONE CALLED ODD?

```ruby
mapped = nums.map do |value|
    if value.even?
        'even'
    else
        value
    end
end
p mapped
```

Yay! But wait, it's not reusable since it's assigned to a variable. so let's take the logic and create a method

```ruby
def even_or_odd array
    array.map do |value|
        if value.even?
            'even'
        else
            'odd'
        end
    end
end
p even_or_odd 1..10
```

you can see here why indentation is so important

### Select

SELECT
in JS we used filter to return a subset of an array based on a condition
in Ruby it is SELECT -- iterator, has built in if statement. returns subset of an array as it makes decision on each item.

```ruby
def only_evens array
    array.select do |value|
        value.even?
    end
end

p only_evens 1..10
```
