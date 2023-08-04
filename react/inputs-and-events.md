# Lecture Notes

## Overview

    1. The DOM tracks interactions with the user
    2. These interactions can be captured and used inside the code logic of the application through JavaScript event listeners

## Process

    * Ensure you are in the cohort-lecture-examples repo
    * Ensure your local is up to date and there are no stale branches
    * Create a new branch
    * Create a React app with the naming convention framework-topic
    * cd into the project
    * Run the project with yarn start
    * Ensure all git commands are done at the repo level and all yarn commands are done at the project level

## Major Takeaways

    * Inputs are HTML/JSX tags that can take attributes such as type and onChange
    * Event listeners are a set of properties and methods in JavaScript that can be referenced by a developer
    * Input values can be captured by a developer and set to state

## Lecture

    React is really good at responding to user interactions. That's why it was named React.  React is able to handle user interactions effectively and efficiently by only making updates where there are changes detected rather than refreshing the entire page. React does this by always listening for any changes made to the DOM.

    - DOM stands for Document Object Model
    - React uses a Virtual DOM which is a representation of the actual DOM which will create a diff every time there is a change

           * Spin up a React App
          - cd into the alpha-lecture-examples repository
          - Create a new branch: react-events-inputs
          - Create a new React application with no spaces:
              * yarn create react-app events-inputs-echo
              * While creating, discuss events
          - cd into the project


    -  Events
        * The browser is always listening for events. An event occurs anytime a user or the browser manipulates a webpage. Examples of events are when a page loads, when the user clicks a button, any key strokes, and resizing a window. All these events can be captured by developers through event handlers, or methods that track events. If you have ever used an onclick/onClick method you have made an event handler.

        - Big data is able to analyze what you click, how often you click, where you click, what you look at, and how you interact with those things.

        -While onclick is often used for button click events, we are going to look at another type of event called onChange which is used to capture text in an input field. Inputs are an HMTL/JSX tags

        * Google "JavaScript inputs", select "HTML Input Types - W3Schools"

        * Input is a self-closing tag, in HTML it can look like this <input> but in JSX it needs to look like this <input />

        * By default the "type" is text but it is a good practice to specify the input type no matter what
          -Play around with a few different types from the W3School docs: password will block characters, checkbox, submit will create a button, etc

```javascript
import React from "react"

const App = () => {
  return (
    <>
      <h1>Get your Echo Cohort Secret Name!</h1>
      <input type="text" />
      <input type="password" />
      <input type="checkbox" />
      <input type="submit" />
      <input type="date" />
    </>
  )
}

export default App
```

    * We are going to want to be able to grab the information from these input tags. That's where onChange comes in:

## OnChange

    * onChange is an attribute that lives on the input tag. Its job is to listen for changes in the input field and capture those changes.
    * Out of the box, onChange provides certain properties.  It is listening for any dom event and will give that to us when we call a method.  Event is a property of the onChange listener
    * This action is a behavior so onChange is going to correspond to a method.

```javascript
import React from "react"

const App = () => {
  const handleChange = () => {}

  return (
    <>
      <h1>Get your Echo Cohort Secret Name!</h1>
      <input type="text" onChange={handleChange} /> // ** Start here! **
    </>
  )
}
export default App
```

      - It is a convention for the method attached to the onChange attributes to be called handleChange
      - onChange automatically passes an argument of event to the method
      - It is common practice for event to be shortened to e

```javascript
import React from "react"

const App = () => {
  handleChange = (e) => {
    console.log(e) // first step
    // - Inspect the page and look at the logs for event
    // - Event is an object that has many key:value pairs
    // - One of the keys is called target which is also an object

    console.log(e.target) // second step
    // - Inside the target there is a key called value that will have a string of the text from the input field
    // third step
    console.log("changed", event.target.value)
    // - Displays the value inside the input
  }

  return (
    <>
      <h1>Get your Echo Secret Name!</h1>
      <label>Enter your name</label>
      <input type="text" onChange={handleChange} />
    </>
  )
}
export default App
```

    - Inside the target there is a key called value that will have a string of the text from the input field
    - Update the log to e.target
    - Update the log to e.target.value

## Setting State

    - Now that we are capturing the values from the input we can set them to state.

    - Create a state variable.
    - Remove console.log and replace with this.setState()
    - Adding a value attribute to connect the state object with what is showing up in the input field
    - With several attributes it is best practice to drop the attributes onto additional lines

```javascript
import React, { useState } from "react"

const App = () => {
  const [userName, setUserName] = useState("")

  const handleChange = (e) => {
    setName(e.target.value)
  }

  console.log(userName)
  return (
    <>
      <h1>Get your Echo Secret Name!</h1>
      <label>Enter Your Name</label>
      // First step: use hardcoded value
      <input type="text" onChange={handleChange} value="Will" />
      // second step: change the value to reflect the current value of state
      <input type="text" onChange={handleChange} value={userName} />
    </>
  )
}
export default App
```

## Passing the Input as Props

    -Now that we have the value in state we can pass the data to another component.
    - I want to use this component to see the input value shown on the page so it will be my display or dumb component

    - Create a folder called components
    - Create a file called UpperCased.js
    - Create a class component with a heading
    - Import the component to App.js
    - Call the component and see the heading render
    - Pass the state value into the UpperCased component
    - Call the value as props

```javascript
// src/App.js
import React, { useState } from 'react'
import Reverse from './components/Reverse'

const App = () => {
  const [userName, setUserName] = useState("")

  const handleChange = (e) => {
    console.log(e.target.value)
  }

  return (
    <>
      <h1>Get your Echo Secret Name!</h1>
      <label>Enter Your Name:</label>
      <br />
      <input type="text" onChange={handleChange} value={userName} />
    </>
  )
}

export default App

// src/components/Reverse.js

import React from 'react'

const Reverse = (props) => {

  const nameReverse = (input) => {
    let reversedName = input.split("").reverse().join("").toLowerCase()
    let firstLetter = reversedName.charAt(0)
    let restOfWord = reversedName.slice(1)
    return `${firstLetter}${restOfWord}`
  }

  return (
    <>
      <h3>{nameReverse(props.userName)}</h3>
    </>
  )
}

export default Reverse

```

## Manipulating the Prop Values

    Inside the Reverse component we can use JavaScript logic to manipulate the output. We don't need state, just a function

    Create a method with a parameter
    Return the parameter in reverse order
    Call the method and pass in the argument of the props values
    // src/components/Reverse.js

```javascript
import React from "react"

const Reverse = (props) => {
  const makeSecretName = (input) => {
    return input.split("").reverse().join("").toLowerCase()
    // let firstLetter = reversedName.charAt(0).toUpperCase()
    // let restOfWord = reversedName.slice(1)
    // return `${firstLetter}${restOfWord}`
  }

  return (
    <>
      <h3> {makeSecretName(props.userName)}</h3>
    </>
  )
}

export default Reverse
export default UpperCased
```

# Additional Notes and Goals

    Revisit the fundamentals of React as you build

# Review

    What is an input?
    What different types of inputs are there?
    What is an event?
    What is the convention for naming the event?
    What data type is the event?
    What does the onChange attribute do?

## Next Steps

    Open the syllabus section and briefly run through the challenges and expectations
    Remind the student to use the react-challenges repo
    Remind the students of the appropriate naming conventions for their branch and project name
    Remind the students that yarn commands happen at the project level and git commands happen at the repo level
    Post pairs in Slack
    Open breakout rooms with ability for participants to choose their room
