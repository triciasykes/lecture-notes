# Javascript Higher Order Functions

## Process

Ensure you are in the cohort-lecture -examples repo
Ensure your local is up to date and there are no stale branches
Create a new branch
Create a Javascript file with the naming convention javascript-higher-order-functions.js
Run the file with node

## Lecture

Let's start off with a bit of review

**_ 1. What is a built-in method? _**

- Premade functions create by developers that are easily invokable. Some take more info and some don't. An example is console.log()

```javascript
console.log(true.toUpperCase())
```

Let's look at the Error:
====> TypeError: true.toUpperCase is not a function

Notice the first part of the error - what do you think this is telling us?
-> Not the correct DATA TYPE

**_ 2. What is a function? _**

- custom set of code that always returns some data
- default is to return undefined

Functions don't always need names. A nameless function is called an Anonymous function

syntax: `() => {}`

**_ 3. What is a parameter? _**

- placeholder for the data being passed into the function

**_ 4. What is an argument? _**

- data that actually gets passed into the function

  ### Pneumonic tool:

  - P for parameter / placeholder
  - A for argument / actual data

**_ 5. What is iteration _**

- Set of instructions executed over and over again until a condition is met

**_ 6. What data types can we perform iteration on? _**

- arrays
- strings

**_ 7. Syntactical Sugar? _**

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

While there are many different higher order functions, we are going to go through two types that you'll use frequently:

- .map
- .filter

- these are specifically ARRAY methods
- if you use them on something else, you will get a TYPE ERROR like we saw earlier

Let's make two arrays that we can use throughout lecture today.

`const showArray = [ <<input shows from class>>]`

`const numsArray = [5, 8, 15, 36, 42]`

## Map

- Map iterates over each element in an array and returns a NEW ARRAY THAT HAS THE SAME LENGTH.
- This means we must assign our map to a new variable!

Map is great for transforming or displaying each of the values in an array.

- all HOFs take anonymous functions as arguments (function that is not defined or set to a variable)

```javascript
const result = showArray.map(() => {
  return "Hey Hotel"
})
console.log(result)
```

<!-- [ 'Hey Hotel', 'Hey Hotel', 'Hey Hotel', 'Hey Hotel' ] -->

Here is the fun and also somewhat confusing part. The ANONYMOUS FUNCTION ALSO TAKES AN ARGUMENT

The required argument is "value"

- this is the value of the element at the current index
- **_(think array[i] in terms of a for loop)_**

If we rewrite the code above adding the value argument

```javascript
const result = showArray.map((value) => {
  return `You like the show ${value}`
})
console.log(result)
```

<!-- <[
  "You like the show Handmaid's Tale",
  'You like the show Euphoria',
  'You like the show The Last of Us',
  'You like the show Killing Eve'
] -->

Unlike a for loop, we cannot tell it where to start and stop - it runs the whole array.

But wait there's more

The anonymous function can also take a second argument "index".

- the current index in the iteration process (think i in terms of a for loop)
- this gives us access to the INTEGER that represents the value's location in the array

```javascript
const result = showArray.map((value, index) => {
  return `You like the show ${value}. It's index is ${index}.`
})
console.log(result)
```

<!-- [
  "You like the show Handmaid's Tale. It's index is 0.",
  "You like the show Euphoria. It's index is 1.",
  "You like the show The Last of Us. It's index is 2.",
  "You like the show Killing Eve. It's index is 3."
] -->

It can take a THIRD argument - "array"

- the original array that you're calling the HOF on. (in our case 'showArray')

```javascript
const result = showArray.map((value, index, array) => {
  return `You like the show ${value}. It's index is ${index} in the array that contains ${array} .`
})
console.log(result)
```

<!-- [
  "You like the show Handmaid's Tale. It's index is 0 in the array that contains Handmaid's Tale,Euphoria,The Last of Us,Killing Eve .",
  "You like the show Euphoria. It's index is 1 in the array that contains Handmaid's Tale,Euphoria,The Last of Us,Killing Eve .",
  "You like the show The Last of Us. It's index is 2 in the array that contains Handmaid's Tale,Euphoria,The Last of Us,Killing Eve .",
  "You like the show Killing Eve. It's index is 3 in the array that contains Handmaid's Tale,Euphoria,The Last of Us,Killing Eve ."
] -->

REMEMBER THIS: there are THREE BASIC PARAMETERS IN HOFS

- VALUE (required)
- INDEX
- ARRAY
  These names are conventions => they can be named anything, what matters is their position

```javascript
let logs = numsArray.map((value, index, array) => {
  return `The value is ${value}, the index is ${index}, the array is ${array}`
})
console.log(logs)
```

<!-- [
  'The value is 5, the index is 0, the array is 5,8,15,36,42',
  'The value is 8, the index is 1, the array is 5,8,15,36,42',
  'The value is 15, the index is 2, the array is 5,8,15,36,42',
  'The value is 36, the index is 3, the array is 5,8,15,36,42',
  'The value is 42, the index is 4, the array is 5,8,15,36,42'
] -->

The order of parameters will ALWAYS be value, index, array but they can be called anything: they are placeholders

```javascript
let logs = numsArray.map((hippo, turtle, lemur) => {
  return `The value is ${hippo}, the index is ${turtle}, the array is ${lemur}`
})
console.log(logs)
```

<!--
[
  'The value is 5, the index is 0, the array is 5,8,15,36,42',
  'The value is 8, the index is 1, the array is 5,8,15,36,42',
  'The value is 15, the index is 2, the array is 5,8,15,36,42',
  'The value is 36, the index is 3, the array is 5,8,15,36,42',
  'The value is 42, the index is 4, the array is 5,8,15,36,42'
] -->

```javascript
const threesArray = [1, 2, 3, 4, 5]

const multiplyBy3 = threesArray.map((value) => {
  return value * 3
})
console.log(multiplyBy3)
console.log(threesArray)
```

<!-- [ 3, 6, 9, 12, 15 ]
[ 1, 2, 3, 4, 5 ] -->

- When using ONLY ONE PARAM IN HOF, you do not need parentheses
- Recognize that you are not console.logging a function. multiplyBy3 is a variable.
- You must have the return inside the HOF or you will get undefined. If you see undefined, you should look if you are missing a return somewhere

Single line function:

- when we are using only one line of code in the code block, we don't need curly brackets or the return keyword. Instead we can write in all in a single line

```javascript
const multiplyBy3 = threesArray.map((value) => value * 3)
console.log(multiplyBy3)
```

- if you have more logic you need to run in your map function, then you need to use curlies

Let's look at an exercise we did last week: create a function that will take in an array of numbers and will display "even", if the number is even, and "odd" if the number is odd.

```javascript
const evenOrOdd = (array) => {
  return array.map((value) => {
    if (value % 2 === 0) {
      return "even"
    } else if (value % 2 === 1) {
      return "odd"
    } else {
      return "oops! Something went wrong!"
    }
  })
}
```

console.log(evenOrOdd(numsArray))

As you can see, there are multiple layers in the block of code. each layer is separated by some curly braces and has a level of indentation to help show the level we are working in within the block of code.

Good examples:
** Let's look at Netflix - Everything about each show's display is consistent
** Look at github to show all repos in the organization
\*\* Use search to filter repos in organization

## Filter

Sometimes we are going to want to iterate over an array and narrow down what is returned and this is where filter comes in.
Just as it sounds, filter will filter out what we don't want and keep only what we do want.

To do this, we will need to provide some kind of a condition like we did above and we will return only the things that meet that criteria

Filter has a built-in IF STATEMENT - it works by looking for boolean values as a return. It will take data that meets the condition (returns true) and move it to new array. This also works on Truthy and Falsey items
In short, it returns a SUBSET of the array

```javascript
let searchP = showArray.filter((value) => {
  return value.includes("p") || value.includes("P")
})
console.log(searchP)
```

**_ Maybe show this as extra example _**

create a function that takes in array of mixed data and returns an array of only odd numbers

```javascript
const mixedDataArray = [
  3,
  "hi",
  true,
  50,
  4,
  null,
  "Bravo",
  52,
  false,
  "yo",
  15,
]

// create fxn named onlyOdds
// parameter is an array
//  we have to make a decision about every item in the array ---> use filter
// inside the fxn create a new variable oneType that will be placeholder fo the filter method by dataType number
// oneType will be only numbers
// filter over oneType and get the odd numbers
// return the final variable

// typeof returns a STRING indicating the data type of the operand's value

console.log(typeof 42) // "number"

const onlyOdds = (array) => {
  let oneType = mixedDataArray.filter((value) => typeof value === "number")
  console.log(oneType)
  let odds = oneType.filter((value) => value % 2 === 1)
  return odds
}
console.log(onlyOdd(mixedDataArray))
```

This might melt your minds a little but we can actually refactor this to be even cleaner

```javascript
const onlyOdds = (array) => {
  let odds = mixedDataArray.filter(
    (value) => typeof value === "number" && value % 2 !== 0
  )
  return odds
}
console.log(onlyOdds(mixedDataArray))
```

## Other Higher Order Functions

Some other higher order functions to possibly explore in your own time are sort and reduce.
