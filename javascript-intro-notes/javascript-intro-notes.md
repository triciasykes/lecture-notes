# JavaScript Intro Notes

### Process

- clone the echo-lecture-examples repo
- cd echo-lecture-examples
- git checkout -b javascript-intro
- touch javascript-intro.js

### What is JavaScript?

What do we know about JavaScript?

- language of the web with html and css
- provides interaction with the user
- updating content
- controlling multimedia
- animation
- etc

Technically, JavaScript is

- dynamically-typed - don't have to explicitly state the datatype during variable declarations. data types can change while beingprogram is used
- interpreted language - read by the browser (may vary on different browsers)
- scripting language - it is interpreted at runtime rather than ccompiled, and executed one line at a time. does not compile the code into machine code before executing.

### Data Types

JavaScript can be broken down into data types. They tell us what type of value a variable has and what type of mathematical, relational, or logical operations can be applied to it without causing an error.

JavaScript has both primitive data types and composite data types. Primative data types are the smalles pieces of JS - can't be broken down any further. Like the cell is the smallest unit of life or the atom is the smallest unit of matter. Primative data types are the building blocks of JavaScript code.

There are 6 Primative data types in JS:

Numbers
Strings
Boolean
Undefined
Null
Symbol

We will take these one by one, but first let me introduce you to a very valuable developer tool: `console.log()`

- terminal is the console
- .log() is a method built-in to JS that will print out the evaluation of what is in the parentheses
- it will not be displayed on your page, only in the console. Great for debugging and just checking everything is working as it should. We will use this a lot!

To view our console.logs we need to run our code. We can do this by making sure we are in the correct directory and using the command
`node filename.js`

### Numbers

- integers and floats
  Which means we can do math!

Examples:
Add
console.log(5 + 3)
Subtract
console.log(5 - 3)
Multiply
console.log(5 \* 3)
Divide
console.log(5 / 3)

The modulo has a special function -> it divides the first number by the second and outputs the REMAINDER. Think long division. No fractions or decimals. This is great for testing for testing even and odd values, for example.

Modulo
console.log(5 % 3)
console.log(6 % 3)
console.log(7 % 3)

### Strings

What happens if I try to console.log(hello world!)?
String must be surrounded by quotation marks
A string can be “A” or it could be “I wonder how hot it will be today!”
It can also be “42” this is a string. Not a number.

**String concatenation** combines separate strings into one
“Hello” + “World!”
“Hello “ + “World!”
“E", "C", "H", "O" how many strings?
“36” + 36
This is called type coercion => js turns the number into a string (more on this later) dynamic typed lang. Changes data types.

### Boolean

- a binary variable, having two possible values
- true
- false
- they are not strings

### Undefined

Variable has been declared but no value assigned

### Null

Does not have a value. It is not zero, it is not an empty string, it is nothing. It lacks value

### Symbol

- Used for accessing keys in JavaScript Objects. We'll address symbols later when we discuss Objects (next week)

### Type Coersion

- converts a value from one data type to another. This happens implicitly when operators or functions are applied to values of different data types

### Variables

var - global variable, it can be reassigned
preferred variable declaration are let and const

let - can be reassigned
const - cannot be reassigned

Name variable - use descriptive names in camelCase

Assignment operator - single equal sign, assigns value to varible

Assigned value - value used when variable is called

var myFavoriteNumber = 42
console.log(myFavoriteNumber) // 42
console.log(myFavoriteNumber + 10) //
console.log(myFavoriteNumber) // 42

#### reassigning variables

myFavoriteNumber = 15
console.log(myFavoriteNumber)

var yourFavoriteNumber = 18
console.log(myFavoriteNumber + yourFavoriteNumber) // 33

### String Properties and Built-in Methods

var message = "Hello Echo!"

**length** property - tells us how many characters the value of the variable is
console.log(message.length)

**index** - tells us the location of each character with the string - returns a value
Computer use zero- indexing so the first character starts at 0
To access a character at specific index we use BRACKET NOTATION

console.log(message[0]) // H
console.log(message[7]) // r
console.log(message[5]) //

charAt() - return value at a specific index
console.log(message.charAt(4)) //

includes() - checks for subset of characters and returns a Boolean
console.log(message.includes("lo")) // true
console.log(message.includes("Lo")) // false
console.log(message.includes("fo")) // false

slice() - returns a subset of characters. Takes 2 arguments: start index of subset, end index of subset

console.log(message.slice(0, 5))
