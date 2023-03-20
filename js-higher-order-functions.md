# Javascript Higher Order Functions

## Process 
  Ensure you are in the cohort-lecture -examples repo
  Ensure your local is up to date and there are no stale branches
  Create a new branch
  Create s Javascript file with the naming convention language-topic.js
  Run the file with node

## Lecture
Let's start off with a bit of review

*** 1. What is a built-in method? ***
- Premade functions create by developers that are easily invokable.  Some take more info and some don't. An example is console.log()
```javascript
console.log(true.toUpperCase())
```

Let's look at the Error:
 ====> TypeError: true.toUpperCase is not a function

Notice the first part of the error - what do you think this is telling us? 
  -> Not the correct DATA TYPE

*** 2. What is a function? ***
- custom set of code that always returns some data
- default is to return undefined

Functions don't always need names.  A nameless function is called an Anonymous function

syntax: `() => {}`

*** 3. What is a parameter? ***
- placeholder for the data being passed into the function

*** 4. What is an argument? ***
- data that actually gets passed into the function

  ### Pneumonic tool:
  - P for parameter / placeholder
  - A for argument / actual data

*** 5. What is iteration ***
- Set of instructions executed over and over again until a condition is met

*** 6. What data types can we perform iteration on? ***
- arrays
- strings

*** 7. Syntactical Sugar? ***
- when developers wrap up large concepts of code/CS in easy to use syntax.
- makes heavey -lifting code functionality "sweeter" to use.

Today we are going to look at some of these complex concepts that are easy to implement. 
There is a log going on under the hood and we won't get into all of it.
We are specifically going to look at Higher Order Functions aka HOFs

## What is a Higher Order Fucntion?
A higher order function is a function that takes a function as an argument
- used by calling on built-in methods
- more efficient than for loops
- but used in very specific circumstances

While there are many different higher order functions, we are going to go through three types that you'll use frequently:
  - .forEach
  - .map
  - .filter

- these are specifically ARRAY methods
- if you use them on something else, you will get a TYPE ERROR like we saw earlier

Let's make two arrays that we can use throughout lecture today.

`const showArray = [ <<input shows from class>>]`

`const numsArray = [5, 8, 15, 36, 42]`

## For Each
- will execute some action ONCE PER ITEM in an array it is attached to
- all HOFs take anonymous functions as arguments (function that is not defined or set to a variable)

```javascript
showArray.forEach(()=> {
  console.log("Hey Bravo")
})
```
<!-- 
Hey Bravo
Hey Bravo
Hey Bravo
Hey Bravo
Hey Bravo
 -->
Why did it print Hey Bravo 5 times? for every iteration, we told it to console.log "Hey Bravo", so we got output of 5 Hey bravos

Here is the fun and also somewhat confusing part. The ANONYMOUS FUNCTION ALSO TAKES AN ARGUMENT

The required argument is "value"
 - this is the value of the element at the current index 
 - ***(think array[i] in terms of a for loop)***

If we rewrite the code above adding the value argument

```javascript
showArray.forEach((value)=> {
  console.log(`You like the show ${value}`)
})
```
<!-- 
You like the show Last of Us
You like the show Succession
You like the show Poker Face
You like the show Rick and Morty
You like the show Ozark 
-->

Unlike a for loop, we cannot tell it where to start and stop - it runs the whole array.
Notice how easy it is to access the values in an array using forEach.

But wait there's more

The anonymous function can also take a second argument "index".
- the current index in the iteration process (think i in terms of a for loop)
- this gives us access to the INTEGER that represents the value's location in the array

```javascript
showArray.forEach((value, index)=> {
  console.log(`You like the show ${value}. It's index is ${index}.`)
})
```
<!-- 
You like the show Last of Us. It's index is 0.
You like the show Succession. It's index is 1.
You like the show Poker Face. It's index is 2.
You like the show Rick and Morty. It's index is 3.
You like the show Ozark. It's index is 4. 
-->

It can take a THIRD argument - "array"
 - the original array that you're calling the HOF on. (in our case 'showArray')

```javascript
showArray.forEach((value, index, array)=> {
  console.log(`You like the show ${value}. It's index is ${index} in the array that contains ${array} .`)
})
```
<!-- 
You like the show Last of Us. It's index is 0 in the array that contains Last of Us,Succession,Poker Face,Rick and Morty,Ozark .
You like the show Succession. It's index is 1 in the array that contains Last of Us,Succession,Poker Face,Rick and Morty,Ozark .
You like the show Poker Face. It's index is 2 in the array that contains Last of Us,Succession,Poker Face,Rick and Morty,Ozark .
You like the show Rick and Morty. It's index is 3 in the array that contains Last of Us,Succession,Poker Face,Rick and Morty,Ozark .
You like the show Ozark. It's index is 4 in the array that contains Last of Us,Succession,Poker Face,Rick and Morty,Ozark .
 -->

REMEMBER THIS: there are THREE BASIC ARGUMENTS IN HOFS 
- VALUE (required)
- INDEX
- ARRAY
These names are conventions => they can be named anything, what matters is their position

```javascript
numsArray.forEach((value, index, array) => {
  console.log("value:", value)
  console.log("index:", index)
  console.log("array:", array)
})
```
The order of parameters will ALWAYS be value, index, array but they can be called anything: they are placeholders

```javascript
numsArray.forEach((turtle, hippo , sloth) => {
  console.log("turtle:", turtle)
  console.log("hippo:", hippo)
  console.log("sloth:",sloth)
})
```

