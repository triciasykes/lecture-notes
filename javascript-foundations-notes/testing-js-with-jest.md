# Testing Javascript with Jest

## Process

- Create a branch
- create a folder called javascript-foundations-jest
- Create a Testing file javascript-jest.test.js extension and no spaces in the name
- $ yarn add jest
- $ yarn jest

Today we are going to talk about Testing our code. Testing is QA for our code. Developers write unit tests for their code to make sure that the code works correctly. This helps to detect and protect against bugs in the future. Sometimes developers write unit tests first, then write the code. This approach known as test-driven development (TDD).

We will be using the Javascript testing framework called Jest Created by Facebook/Meta. it is most commonly used for Unit testing => provide input to a function or other unit of code and match the output to the expected output.  
Jest is a collection of files managed by a package manager named yarn.

Code is shared through something called a package. A package contains all the code being shared. Yarn is a package manager for your code. It allows you to use and share code with other developers from around the world. Yarn does this quickly, securely, and reliably so you don't ever have to worry. Yarn allows you to use other developers' solutions to different problems, making it easier for you to develop your software.

**_ Why test?_** The obvious is you don't want your code to break when it goes live. You will be getting paid to produce a live product, and you'll probably want to keep your job. But if we go beyond the paycheck, testing will make you a better developer.

Testing your code teaches you how to write good code because you have to fix all of your bad code. When you have to go through and fix your own bugs you learn different ways to solve problems. The number of ways you can break code is immeasurable and that's what makes it so interesting.

Finding and fixing errors helps you know what to look out for when you write your code in the first place. That's how you get experience as a web developer. You write code and fix it. The more testing you do, the more exposure you'll get to different kinds of bugs.

The more bugs you see, the more you'll stop writing them. Therefore, you'll become a powerful developer. Testing is the teacher that you'll hold onto for your entire career because you learn so much from it. Even if you don't feel like learning.

So today we will begin practicing TDD. Breaking the code into a series of tests helps us break the big problem down into much smaller ones, and smaller problems are easier to solve, so we write dramatically better code because of it. If you have solid tests and decide that you want to refactor some part of your application because either the requirements of the application changed, or you realized a better way, you can do so with confidence.

### TDD :

The process
red-green refactor

1: Write the test first!
2: Run your testing suit to see a failing test
3: Write the code
4: Run your testing suit to see your test pass
5: Refactor if necessary

One of the fastest ways to prove to future employers that you care about your code, and know what you are doing, is to write good tests. When we write our tests first, then write the code required to make them pass, we as developers, are thinking about our code in a different, more logical way. Your tests speak volumes about you as a developer, as much or more than the actual code.

### Process of testing

Prompt: Create a function called greeter that returns a string that says Hi, Alpha 2024!!!

1. Write the test first!

**_ Explanation of Testing Syntax with Jest (explain while pseudocoding in the text editor) _**
Jest uses a method called describe() that runs other nested methods. Let's go over the syntax first - make a template-like structure
First we inovke the describe method, providing the argument of "greeter" which is our function name, followed by a comma, then an anonymous function to allow us to nest more code within it's block scope.

````javascript
 describe("functionName", () => {
  it("short description of what fxn should do", () => {
    //
    expect(functionName(input)).toEqual(output)
  })
 })

```javascript
// a describe method that lists the name of the function
describe("greeter", () => {})
````

Second, we invoke the test method, providing it an argument that in describes in plain words what the function does, followed by a comma, and another anonymous function

```javascript
// use a test or it method, nested in the describe block that describes what the fxn does
it("returns a string that says Hello Alpha 2024", () => {})
```

Third we invoke the expect method, providing it an argument of the function call
and then chain a matcher to the end of it, in this case we use toEqual(), which will check that the return of the function to be a string that says exactly "Hello Bravo 2023!".

```javascript
// expect will invoke the function and compare the result to a predetermined output using .toEqual matcher
expect(greeter()).toEqual("Hello Alpha 2024!")
```

This is like saying:
`console.log(greeter()) === "Hi,Alpha 2024!"` 2. Run your testing suite to see a failing test.

Run `yarn jest` in the terminal to run the test. We can expect that the test will fail since we haven't created the function yet (the red part of red-green refactor).

Yes! A good failure! The test points to exactly where the issue is in the code through an error message and an arrow `^` at the point it failed. The test is looking for a function called greeter and cannot find onw. We can tell this is the case because of the ` ReferenceError: greeter is not defined` part of the message. This tells us that our test is written correctly, but it failed because when our expect method tried to invoke the function greeter(), it couldn't find it. It's important to read the fail/error messages thoroughly because it won't always be a Reference Error. Jest will give us a good indication as to where it went wrong. In this case, it faile where we expected it to.

3. Write the code. Now that we got the Red, the good failure, we can build the function to make the test pass (the green part of red-green-refactor)

```javascript
const greeter = () => {
  return "Hello Bravo 2023!"
}
```

Notice: There is no console.log() or function call. Jest handles all of that in the expect method. Our function name AND the return must exactly match what we provided our expect and matcher methods. Now our test should pass (green).

4. Run your testing suite to see your test pass

5. Refactor if necessary. Our test passes and we can now move on to creating more tests.

Let's try a few more complex examples

Write a test for a function that logs "help others" if you do understand or "ask questions" if you do not understand.

```javascript
describe("doYouUnderstand", () => {
  it("returns help others or ask questions based on input", () => {
    expect(doYouUnderstand("yes")).toEqual("help others")
    expect(doYouUnderstand("no")).toEqual("ask questions")
  })
})

const doYouUnderstand = (string) => {
  if (string === "yes") {
    return "help others"
  } else if (string === "no") {
    return "ask questions"
  } else {
    return "no help for you!"
  }
}
```

Notice we don't comment out the old tests and functions. We leave those there and this composes a test suite. The purpose of having tests is so that they are automated - we simply keep the original code and tests and keep writing new ones below those.

Sometimes it can be useful to create variables within our test method for use later on in our expect methods. Note - these variables are only available within the scope of the specific test in which it's created

Prompt: Create a function that takes in an array and a string and appends the string to the end of the array

Input: ["take notes", "pay attention", "practice", "take breaks"], "ask questions"
Output: ["take notes", "pay attention", "practice", "take breaks", "ask questions"]

Template test:

```javascript
describe("functionName", () => {
  it("what function does", () => {
    expect(functionCall(input)).toEqual(output)
  })
})
```

```javascript
describe("becomeADeveloper", () => {
  it("takes in an array and a string and appends the string to the end of the array", () => {
    let developerList = ["take notes", "pay attention", "practice", "take breaks"]
    let developerString = "ask questions"
    let result = ["take notes", "pay attention", "practice", "take breaks", "ask questions"]
    expect(becomeADeveloper(developerList, developerString)).toEqual(result)

  // expect(becomeADeveloper(["take notes", "pay attention", "practice", "take breaks"], "ask questions")).toEqual(["take notes", "pay attention", "practice", "take breaks", "ask questions"])
  // })
})

// Good Fail: ReferenceError: becomeADeveloper is not defined

const becomeADeveloper = (array, string) => {
  return array.concat(string)
}
```

const stockExchange = [13, 34, -4, 42, 5, -5, 10, 27, 42, 10]
const cohortList = ["Alpha", "Bravo", "Charlie", "Delta", "Echo", "Foxtrot"]

const getThreeFourFive = (array) => {
const justThree = [];
for (let i = 3; i < 6; i++) {
justThree.push(array[i]);
}
return justThree

}

console.log(getThreeFourFive(stockExchange)) //[42, 5, -5]
console.log(getThreeFourFive(cohortList)) //[42, 5, -5]
