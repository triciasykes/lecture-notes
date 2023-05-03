#  TESTING WITH JEST AND REACT TESTING LIBRARY
At this point, we have done our basic setup for our frontend applicaiton. While there are a lot of things that differ between frontend and backend, one thing that persists across all coding principles is testing.

Testing can locat problems that otherwise may take us a long time to find just by poking around our application.

Before we start writing our tests, I want to talk about some of the different types of testing we may run into as developers.

 - Static: Consists of peer reviews and inspecting pages looking for syntax mistakes. Basically, we are poking around our application or asking others to check that our code looks efficient.
 - Unit: Looks at one portion of the code and verifies it's giving an expected result.
 - Integration: Tests how our code is working together in our application
 - End-to-end: Automates the user going through the whole application.  We won't touch on end-to-end testing in class, but it is certainly worth diving into if you are interested in testing.

Let's start by looking at Trello.  

Today we are going to learn some new methods to help us test in React. We will need two technologies - Jest and Testing Library.  Luckily for us, these are both added by default when we use Create REact App.  

*** SHOW PACKAGE.JSON ***


It finds tests, runs tests, and determines if they pass or fail.

 React Testing Library (RTL) provides methods to help you write the tests. It simulates user interactions on isolated components to ensure the UI behaves as desired. RTL provides virtual DOMs. Thier guiding principle: 
 
    The more your tests resemble the way your software is used, the more confidence they can give you.

Side note - RTL was made as a replacement to Enzyme.  The biggest difference in the two is the philosophy behind each.  Enzyme tests a component's implementation details, React Testing Library puts the developer in the shoes of an end user of an React application. In 2018 Delta, we learned Enzyme and it was still part of the curriculum until very recently. 

Let's open the terminal and run yarn test.

We haven't written any tests?  Where is this coming from? App.test.js

Let's look at that file to get familiar with RTL

``` javascript

import { render, screen } from '@testing-library/react';
import App from './App';

test('renders learn react link', () => {
  render(<App />);
  const linkElement = screen.getByText(/learn react/i);
  expect(linkElement).toBeInTheDocument();
})
```
At the top, we see we are importing several things. We are bringing in render and screen from the testing-library
- render: allows me to call upon that component
- screen: allows me to actually see the whole node tree that gets sent to the user
- App component - since were are testing that component we need to import it as well.

You can access the rendered HTML through the screen object.
getByText(): find the element by its textContent value

Why is it failing?  We changed App.js!  
Also, since App.js is just rendering other components, we don't need to test it.
We want to test the individual components.  So let's just delete this file.  Yeah!

Let's look at Trello - first task - test coverage on my Home Component

First we are going to create a testing folder: _tests_let's go create a Home.test.js file (yes, you will have to add a test file for each component you are testing.  In Cat tinder, we just have these four components that you have to have some test coverage on.  In the wild, you will typically need 70-90% test coverage.  What is test coverage: that amount of your code must have associated tests.  FYI, for your Capstone the requirement is 60% for both FE and BE).  So start having fun with testing. :)

We have used Jest before. It is the most popular testing framework for JS apps.  Perhaps you remember.  Jest actually runs the test code as well as give us the the format with these functions:

```javascript
describe('my function or component', () => {
    it('does the following', () => {
      expect()
  })
})
```

Great, now inside of our it, there are also three stages we need to consider. Arrange, Act, and Assert.

Arrange: what is needed to setup the environment that I am testing. In this case, I need to render my component that I want to test (App.js)

Act: getting the method I need to pull this information. Here I know I want to see a greeting, so I can store it in a variable

```javascript
// only pulling one piece of the library out
import { render, screen } from '@testing-library/react'
import Home from './Home'

describe("<Home/>", ()=> {
    //A user can see the home page
    it("renders the home page for the user", ()=> {
// TRIPLE A approach - very common in testing.  Arrange, Act, Assert
    
        // Arrange - set up a condition
        render(<Home/>)
        screen.debug()
        //Act - act on that condition (interactions/passive)
        const element = screen.getByText(/it's like Tinder, but for Cats!/i)
        // Assert - what is expected
        expect(element).toBeInTheDocument()
        screen.logTestingPlaygroundURL()
    })
})
```

// // most basic test - doesn't test the whole component.  It only checks line 14
// // this is a unit test - it tests one thing.  As developer you will write a ton of unit tests.
// // This test will only tell us if Home fails or line 14 fails. 

Remember - RTL is interested in the way a user interacts with the app.  Do the things function in front of a user.  Set up one test for each idea.

So let's look at an interaction  --- Header.js
create Header.test.js

```javascript
// pull in same imports from Home test
import { render, screen } from "@testing-library/react";
import userEvent from "@testing-library/user-event";
import { BrowserRouter } from "react-router-dom";
import Header from "./Header";
// Header is not wrapped in Routes - this has to do with way rtl interacts with router.  So we import BrowserRouter and wrap header comp in it
describe("<Header/>", () => {
  test("Header renders without error", () => {
    render(
      <BrowserRouter>
        <Header />
      </BrowserRouter>
      )
    const indexLink = screen.getByText(/Meet the Cats/i)
    expect(indexLink).toBeInTheDocument();
  })  

  test("Header has clickable links", ()=> {
    // Arrange
    render(
      <BrowserRouter>
        <Header />
      </BrowserRouter>
    )
    // Act
    // set up section action
    // test click on link - need to tell test to act like a user. What ways can user interact with application?
    // we need another tool set from testing library ==> userEvent
    // this is also an assertion - will error if broken
    userEvent.click(screen.getByText("Meet the Cats"))
    expect(screen.getByText("Meet the Cats")).toBeInTheDocument()
    userEvent.click(screen.getByText("Add a New Cat"))
    expect(screen.getByText("Add a New Cat")).toBeInTheDocument()
    userEvent.click(screen.getByText("Adopt a Cat!"))
    expect(screen.getByText("Adopt a Cat!")).toBeInTheDocument()
  })
})


```

Review
Troubleshooting:

- Check imports

- You'll be using the same function template that you've been using: describe block, test/it block, expect

- BrowserRouter will need to be included for components not wrapped in Routes

- testing interactions you will need to import userEvent

- debugging tools:  screen.debug() screen.logTestingPlaygroundURL()

