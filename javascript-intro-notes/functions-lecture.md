it assembles# JavaScript Functions Lecture

Updated: August 2023

# 📚 Assets

- [Syllabus: JavaScript Functions](https://github.com/LEARNAcademy/syllabus/blob/main/javascript/functions.md)

---

# 👩‍💻 Setup

- Open syllabus to JavaScript Functions section
- Clone repo if necessary
  - `git clone <url>`
  - `cd repo`
- Create a branch: `git checkout -b javascript-functions`
- Create a new file: `touch javascript-functions.js`

---

# 🧑🏻‍🏫 Lecture

### Functions

- **Functions** are reusable blocks of code that perform a specific task. Think of them as little machines. Their main job is to take in an input, do something, and produce an output. For example, think about a juicer - you give it fruit and or veggies, and outputs juice.

There are a few ways to define a function. The way we use functions at LEARN is by using the **arrow syntax**. Arrow syntax was introduced in 2015, as part of the ES6 version of JS. The prior way to define functions was by using the reserved keyword `function`. You may still see this style of definition.

### Anatomy

- Const
  - Variable declaration
- Arrow Syntax (function expression)
  - ( )
    - Funnel we can pass data through
  - =>
    - The es6 arrow is the replacement for the keyword function
  - {}
    - The curly braces represent the area where we can write our javascript code in
- Return
  - Every function must output something. The output is defined by the keyword `return`.

Example:

```js
const functionName = () => {
  return "output"
}
```

### Output and Invocation

So let's set up a working example. We are going to make a coffee maker with a function.

- Run the file `node javascript-functions.js`

```js
const makeCoffee = () => {
  return "Coffee is made!"
}
```

ERROR: Nothing is displayed

Functions don't do anything at all until we tell to. Executing or using a funciton is called `invoking/running/calling` (interchangeable.)

- Write the invocation
- Run the file `node javascript-functions.js`

```js
const makeCoffee = () => {
  return "Coffee is made!"
}
makeCoffee()
```

ERROR: Nothing is displayed.

We still need to log our outcome to see anything in the terminal.

- Log the invocation
- Log the invocation many times

```jsx
const makeCoffee = () => {
  return "Coffee is made!"
}
console.log(makeCoffee())

// second part:
console.log(makeCoffee())
console.log(makeCoffee())
console.log(makeCoffee())
```

### Parameters and Arguments

Functions are designed to be reusable and dynamic.

- Functions can take inputs
- Functions are encapsulated so the only outside influence in a function should be through the designated inputs
- **Encapsulation** - code should only have access to information that the developer decides, predictable behavior
- The inputs are special variables called **parameters**
- Functions should only have data that have been passed into the code via the **argument**
- The parameters should be relatively neutral while as descriptive as possible for their purpose
  My pneumonic method of remembering the difference between parameters and arguments:
  P - parameter, placeholder
  A - argument, actual data passed in when function is called

```jsx
const myFunction = (parameter) => {
  return "output"
}
myFunction(argument)
```

```jsx
const sandwichMaker = (ingredient1, ingredient2) => {
  return `Enjoy your ${ingredient1} and ${ingredient2} sandwich.`
}
```

- Invoke function

```jsx
console.log(sandwichMaker())
```

ERROR: Undefined since the parameter is a variable without an assignment

- The value of a parameter gets defined in the function invocation called an **argument**

```jsx
console.log(sandwichMaker("ham", "swiss"))
console.log(sandwichMaker("turkey", "cheese"))
console.log(sandwichMaker("peanut butter", "jelly"))
```

What if we want to actually use the output later in our code? we can save it in a variable

```jsx
const pastramiSandwich = sandwichMaker("pastrami", "swiss")
console.log(pastramiSandwich)
```

Now we can use that variable anywhere else in the program

### Pseudo Code

As the code we are creating gets more complex, more work is required to break down the problem. **Pseudo coding** is the term for writing process notes in plain English. When pseudo coding functions it is important to think about the inputs and outputs, also known as the **function signature**, and the steps in between to get to that output.

- Build out a function that takes a coffeeType and a size and returns a statement with the appropriate price
- Functions have to return something
- Only one output in an conditional statement will ever be executed

```jsx
// create a function called makeCoffee
// input: coffeeType(string) and size(string)
// output: string - "Your (size) (coffeeType) is $amount"
	// Determine set prices: small - $3, medium - $4, large - $5
// use conditional statement to make an evaluation on the size
// if the size evaluates to large, it will cost $5
// if the size evaluates to medium, it will cost $4
// if the size evaluates to small, it will cost $3
// if none of the above are true, return an error message

const orderCoffee = (coffeeType, size) => {
  if(size === "large") {
    return `Your ${size} ${coffeeType} is $5`
  } else if(size === "medium") {
    return `Your ${size} ${coffeeType} is $4`
  } else if(size === "small") {
    return `Your ${size} ${coffeeType} is $3`
  } else {
    return "Sorry that is not on the menu."
  }
}

console.log(orderCoffee("latte", "small")
console.log(orderCoffee("mocha", "medium")
console.log(orderCoffee("chai", "large")
console.log(orderCoffee("regular", "extra large")
```

---

# 🔤 Recap of Vocabulary

- **function** - a code block designed to perform a specific task and that is reusable
- **encapsulation** - a way to keep internal pieces of a function from the rest of the code base
- **arrow syntax** - provides a shorter syntax for writing function expressions
- **function expression** - a way to define a function
- **function invocation / function call** - the process of executing a function
- **parameter** - placeholder variables for values that will be passed to a function
- **argument** - actual values passed to a function when it is called
- **function signature** - the inputs and outputs of a function
- **pseudo coding** - logic is written in plain language and used as a planning step before writing actual code

# 🕵️ Recap of Major Takeaways

- To run a function, you will need to invoke or call the function.
- Parameters are the placeholder variables within a function, while the argument in the function call is the value passed to the parameter.

---

# 🏃 Next Steps

- Push lecture notes to GitHub
- Merge and delete branch
- Walkthrough challenges
- Remind the student to use the `javascript-intro-challenges` repo
- Remind the students of the appropriate naming conventions for their branch and file
- Post pairs in Slack
- Open breakout rooms with ability for participants to choose their room
