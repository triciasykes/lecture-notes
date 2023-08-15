# JAVASCRIPT LOOPS LECTURE NOTES

### Iteration
**Iteration** - the process of repeating an action over and over again a certain number of time or until a condition is met.

 ### Scope and Variable Declarations 
 Before we go any further though, I need to introduce you to variable declarations and scope
 Scope refers to where a variable is accessible or visible:
  1. Global - can be accessed/seen anywhere in the program
  2. Local (aka block scope) - only available inside the block in which it is defined

3 Variable declarations:
  1. var - global scope, it can be accessed anywhere inside or outside of a block and it's value can be reassigned. This was the only var declaration in JS until 2016 when ES6 was released and gave us 2 more.  Why? global variables can accidentally be reassigned in various parts of your program.  Use with caution. Most js code typed these days uses let and const
  2. let - only available inside the block in which it's defined - it can be reassigned, but not redeclared.
  3. const - cannot be reassigned or redeclared.

  **VIEW CHART IN SYLLABUS**

  Let's look at some examples:

  First let's look at var -- global scope
  ```javascript
    if(true) {
      var myName = "Trish"
      console.log(myName)  // This will work (accessing inside block)
    }

    if(true) {
      var myName = "Trish"
    }    
    console.log(myName)  // This will work (accessing outside block)
  ```
  Now let -remember, local scope - can only be accessed within the block
  ```javascript
  if(true) {
    let yourName = "Felix"
    console.log(yourName)  // This will work
  }

  if(true) {
    let yourName = "Felix"
  }
    console.log(yourName)  
   // <!-- Now look at reassigning let -->


  let myCat = "Geppetto"
  console.log(myCat) //  "Geppetto"  

  myCat = "Kevin"
  console.log(myCat)  // "Kevin" this works!

  const myDog = "Nika"
  myDog = "Theo"
  console.log(myDog) // This will throw error  
  ```

  ### LOOPS
  Ok, so now we understand a bit more about variables and scope. So let's look at how that information is important for For Loops.

  Today we'll be discussing the FOR LOOP.  
 - for loops defines a variable and increments or decrements the variable on each iteration
 - for loops run until a condition is met
 - they do not innately connect to arrays, but we use them on arrays
 - they are great for counting

  There are three pieces of information we need to set up a for loop
 - where to start counting
 - where to stop counting
 - how to get from the start to the stop (increment)

 Info needed to set up a for loop
   it is common to use the variable name index to store current count (shorthand uses `i`)
 - where to start counting (let index = 0)
 - where to stop counting (index < 10)
 - how to get from the start to the stop (increment) (index = index + 1)

 Longhand way used for education/understanding:
 
 ```javascript
 for(let index=0; index<10; index=index+1) {
  // do something here
}
```
Customary syntax is shorthand

```javascript
for(let i=0; i<10; i++){
  console.log(i)
}
```

### Connecting Loops to Arrays

What do we know about arrays
  1. Arrays start with index 0 
  2. All arrays have a length property
  3. Once we have an index, we can extract the value

Let's make a short array of numbers

```javascript
const numsArray = [4,5,6,7,8,9]
console.log("length: ", numsArray.length)

for(let i=0; i<numsArray.length; i++) {
  console.log("index", i, "value", numsArray[i])
}
  // --- Creating Logic in the Loop
  
  for(let i = 0; i < numsArray.length; i++) {
    if(numsArray[i] % 2 !== 0) {
      console.log(`${numsArray[i]} is an odd number!`)
    } else {
      console.log(`${numsArray[i]} is an even number!`)
    }
  }


  //  tip  i+=2  