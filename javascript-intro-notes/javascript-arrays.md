# Arrays Lecture Notes

To talk about Arrays, it's important to start with talking about data structures. A data structure is a way of organizing data so you can easily an efficiently access and use it. Data structures allow us to know where things are and how to find them. Think of your utensil drawer - everything has its slot - you know where to go to get what you need. If you walk into someone's else's kitchen and they point you to the utensil drawer, it's a pretty good assumption that you can find a fork.
Now compare that to a junk drawer. There's no rhyme or reason - the thing I'm looking for may be in there - it may not. I may have to dump out the whole drawer and pick through it to perhaps find the one thing. Not easy, not efficient. In programming we want to get, manipulate, and store data, so finding the best data structure is very important.

An array is a data structure used to store a collection of data in an indexed list. to put this simply - an array is a list of items between square brackets.

Each item in an array is called an element.

[ 1, 2, 3, 4, 5 ]

- zero-indexed so 0,1,2,3,4 in this case
- length = 5

Let's look at how to use arrays in JS

Arrays can be stored in variables, ust like we did yesterday with strings, numbers, and booleans

let cities = ["San Diego", "Chicago", "New York", "Austin", "Dallas/FW"]

syntax: elements are separated by commas, wrapped in square brackets

Yesterday we talked about strings and ways to access characters by using the index. We can also get individual elements from array by using Bracket Notation.

console.log(cities[2])
console.log(cities[3])
console.log(cities[0])

What happens if we try an index that doesn't exist? Undefined

console.log(cities[6]) // undefined

we can also have an array of mixed data

let newArray = [ "Kevin", 42, true, "vampire", false, null, "hippo" ]
we can still access with bracket notation
console.log(newArray[3])

We can also assign values
newArray[7] = 8
console.log(newArray)

We can also REASSIGN values
newArray[0] = "Geppetto"
console.log(newArray)

we can also use the .length property on arrays!

console.log(newArray.length)

We can also set a variable to an empty array

let pets = []

## Built-in Methods

### Setters and Getters

- Setters: aka mutators (alter the original array)
- Getters: aka accessors do not change original array

using the following array:

let animals = ["cat", "horse", "dog", "pig", "giraffe"]

**Setters**
.push() add an item to the end of an array. Takes an element as an argument

console.log(animals.push("elephant"))
console.log(animals)

.pop() removes the last element from the array and returns its value - doesn't take argument
let list = animals.pop()
console.log(list)
console.log(animals)

.concat() - concatenates 2 arrays. Call the method on one array, pass other as argument. have to set to new variable, doesn't change the original arrays.

let vampires = [“Spike”, “Angel”, “Dracula”]
let combined = animals.concat(vampires)
console.log(combined)
console.log(vampires)
console.log(animals)

let someLetters = [“b", "u", "f”, "f", "y"]
console.log(someLetters.join(""))

.join() can take a DELIMITER, ie. a space, comma, happy face….

.split(‘’) - used on a string to divide into ordered list in an array.

let string = 'Today it is very hot'
console.log(string.split())

### Destructuring

destructuring assignment syntax is a JavaScript expression that makes it possible to unpack values from arrays, or properties from objects, into distinct variables.

let fullName = ["Tricia", "Sykes"]
let [firstName, lastName] = fullName

console.log(firstName)
console.log(lastName)
