#  TESTING WITH JEST AND REACT TESTING LIBRARY

Today we are going to learn some new methods to help us test in React. We will need two technologies - Jest and Testing Library.  Luckily for us, these are both added by default when we use Create REact App.  

*** SHOW PACKAGE.JSON ***

We have used Jest before. It is the most popular testing framework for JS apps.  Perhaps you remember.  Jest actually runs the test code as well as give us the the format with these functions:

```javascript
describe('my function or component', () => {
    test('does the following', () => {
      expect()
  })
})
```

It finds tests, runs tests, and determines if they pass or fail.

 React Testing Library (RTL) provides methods to help you write the tests. It simulates user interactions on isolated components to ensure the UI behaves as desired. RTL provides virtual DOMs. Thier guiding principle: 
 
    The more your tests resemble the way your software is used, the more confidence they can give you.

Side note - RTL was made as a replacement to Enzyme.  The biggest difference in the two is the philosophy behind each.  Enzyme tests a component's implementation details, React Testing Library puts the developer in the shoes of an end user of an React application. In 2018 Delta, we learned Enzyme and it was still part of the curriculum until very recently. The video in the syllabus has not been updated. That lecture talks about Enzyme, so my apologies to anyone who tried to watch to get a headstart. As you know, technologies are constantly changing and updating, so we have to roll with it.

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

You can access the rendered HTML through the screen object.
getByText(): find the element by its textContent value

Why is it failing?  We changed App.js!  
Also, since App.js is just rendering other components, we don't need to test it.
We want to test the individual components.  So let's just delete this file.  Yeah!

Let's look at Trello - first task - test coverage on my Home Component

let's go create a Home.test.js file (yes, you will have to add a test file for each component you are testing.  In Cat tinder, we just have these four components that you have to have some test coverage on.  In the wild, you will typically need 70-90% test coverage.  What is test coverage: that amount of your code must have associated tests.  FYI, for your Capstone the requirement is 60% for both FE and BE).  So start having fun with testing. :)

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
        //Act - act on that condition (interactions/passive)
        const element = screen.getByText(/it's like Tinder, but for Cats!/i)
        // Assert - what is expected
        expect(element).toBeInTheDocument()
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
