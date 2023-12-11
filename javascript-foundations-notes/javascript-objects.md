# JavaScript Objects Lecture Notes

We have talked about JS data types. Let's just run through those for fun -

- Primitive data types - number, string, boolean, null, undefined, symbol
- Collections of data - array. These can be broken down into smaller parts.
- non-primitive data types, collection of data, is called an **object**

You've seen objects, just maybe without knowing it. We're all a bit familiar with CSS.
Let's look at a piece of css

```css
h1 {
  /* key value pairs, css property that is modified with the value */
  color: "purple";
}
```

In JS we can store data in key-value pairs. Let's break it down into its parts:

- object syntax, collections of key value pairs:-
  `{ key: "value" } `
  `{}` - defines the object the same way [] defines an array
  `value` - any data type recognized by JS
  `key` - symbol, unique identifier, primitive data type used in objects

- can put as many k-v pairs in object, separated by commas
- objects are typically assigned to a variable

```javascript
const myObject = {
  key1: "value",
  key2: "another value",
  key3: "one more value",
}
console.log(myObject)
```

Ok, so we have our basic structure. Now how do we access one value from the object? Let's think about arrays - how do we access a specific value from an array. Bracket Notation. In arrays, values are defined by their index. However, in objects, values are defined by their key. So bracket notation doesn't work here. Instead we use DOT NOTATION which syntax is objectName + . + key

console.log(myObject.key3)
--> one more value

```javascript
const person = {
  firstName: "Walter",
  lastName: "White",
  city: "Albuquerque",
  occupation: "Chemistry Teacher",
  contact: { phone: 404-555-1234, email: heisenberg@example.com, venmo: "@BlueSky-3" }
}
// Let's get this person's first name
console.log(person.firstName)
// What if want to get his venmo account?
console.log(person.venmo)
// --> undefined
// ok, so let me try just console.logging the key directly
console.log(venmo)
// --> ReferenceError:venmo is not defined
// So JS sees it as thing that exists, but

console.log(person.contact.venmo)
// --> @BlueSky-3

// Nested objects need the entire pathway to access the value
console.log(
person.contact.phone,
person.contact.email,
person.contact.venmo
)
```

But this is lengthy and time-consuming. Also easy to make typos if you want to use this value often. If you're going to be accessing nested values repeatedly, then we can use the shortcut of destructuring
destructuring - unpacking the pathway of an object and assigning it to variable
Syntax for destructuring an object: we use { } because it's coming from an object, and the variable name will be the key:

```javascript
const { phone } = person.contact
console.log(phone)

//  We can actually do all 3 in one destructuring
const { phone, email, venmo } = person.contact
console.log(venmo)
```

### Methods

As we've seen Objects can hold data and an object can also hold behavior
A method is a function (behavior) that belongs to an object
Let's create an object that holds numbers and then a fxn called addUp that will output the sum of all the values.

```javascript
const numberObject = {
  num1: 8,
  num2: 15,
  num3: 42,
}
console.log(numberObject)
```

```javascript
const numberObject = {
  num1: 8,
  num2: 15,
  num3: 42,
  addUp: function () {
    return num1 + num2 + num3
  },
}
console.log(numberObject)
```

But this brings us to the question of how do I reference the object when I'm inside of the object.

### This

this - keyword in JS that is a reference to the name of the object when you are inside the object

```javascript
const numberObject = {
 num1: 8,
 num2: 15,
 num3: 42,
 addUp: function () {
   return this.num1 + this.num2 + this.num3
 }
}
// Now how do we call method.
console.log(addUp) - addUp is a method, belongs to the object
// it doesn't exist outside the scope of the object
console.log(numberObject.addUp)
--> [Function: addUp]
// This tells me there is a function called addUp, but doesn't actually run it.  What do we always need to invoke a method? parentheses!
console.log(numberObject.addUp())
--> 23
```

Just a quick note - we do not use arrow functions when defining custom methods. Rather we use the function declaration.

### Array of Objects

We often see a collection of objects in an array so let's see how we can interact with these.

```javascript
const pets = [
{ name: "Taco", type: "dog", age: 5 },
{ name: "Lizard", type: "dog", age: 1 },
{ name: "Steve", type: "cat", age: 2 },
{ name: "Charlie", type: "cat", age: 10 }
]
console.log(pets.length)
--> 4

console.log(pets[0])
--> { name: 'Taco', type: 'dog', age: 5 }

console.log(typeof pets[0].name)
--> string

console.log(pets[0].name.toUpperCase())
--> TACO

console.log(pets[0].age.toUpperCase())
--> TypeError: pets[0].age.toUpperCase is not a function

const pets = [
{ name: "Taco", type: "dog", age: 5 },
{ name: "Lizard", type: "dog", age: 1 },
{ name: "Steve", type: "cat", age: 2 },
{ name: "Charlie", type: "cat", age: 10 }
]
// When building more complex data structures, we need to think about the right tools for each data structure

console.log(pets.name) //--> undefined
console.log(pets[0])
console.log(pets[0].name)
console.log(pets[0].name.toUpperCase())
```

### use HOF to iterate over array of objects

```javascript
// Let's say we want to get all the pet names - just the names.  What tool can we use?
// get all the pet names
const getAllTheNames = pets.map((value) => {
// console.log("this is one iteration:", value.name)
return value.name
})

console.log(getAllTheNames)
--> [ 'Taco', 'Lizard', 'Steve', 'Charlie' ]


// Now what if I want to get all the pet names in all caps, and have it be a dynamic function?

const getAllTheNames = (array) => {
// console.log(array.toUpperCase()) --> error
return array.map((object) => {
// console.log(object.toUpperCase()) --> error
console.log(object.name.toUpperCase())
return object.name
})
}
console.log(getAllTheNames(pets))


// create a function that returns the name and type of each pet

//Pseudocode:
// declare a function
// iterate .map()
// return result

//input = pets array
// output =  "Tala is a dog"

const petType = (arrayOfPets) => {
    return arrayOfPets.map(value => {
        return `${value.name} is a ${value.type}`
    })
}

console.log(petType(pets))

const petName = (array) => {
    return array.filter(value => {
        return value.age >= 8
    })
}
console.log(petName(pets))
```

JSON - JavaScript Object Notation, language of data on the internet
