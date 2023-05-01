# CAT TINDER READ FUNCTIONALITY AND TESTING NOTES

### Setup

- $ cd cat-tinder-frontend
- Show Trello board
  - review each item on card and discuss what that means
  - checkout branch read-functionality
- $ code .

### Lecture

We are now at the point where we can start coding our CRUD functionality. Today we are on the READ functionality - there are 2 RESTful routes that correlate to Read.

1. Index - get all things
2. Show - shows one instance of the things

Quick review of the routes. Remember we put them all in App.js. Route Components can only live within the Routes Tags. As we talked about yesterday, the Route component takes two attributes, path and element, and the element is a component call. Which means we can pass props here.

```javascript
<Route path="/catindex" element={<CatIndex cats={cats} />} />
```

the state variable cats is holding the array of cats that we are importing from this mockCats.js file. This file mimics the information we expect to from the backend. We won't be using it in the final product - we will actually be pulling the cat data from the database - this is why we don't want to just import the file into CatIndex.

Now over in CatIndex we will need to pass the destructured object cats into the arrow function of the CatIndex functioncal component. We could use props and then use object notation to drill down to the info we need, but I think this way is easier to understand and definitely cleaner.

```javascript
const CatIndex = ({ cats }) => {
  console.log("Cat Index props: ", cats)
  return (
    <>
      <h3>Cat Index Page</h3>
    </>
  )
}
```

Now we can do something with this data! What's the purpose of this page? To display all the cats. And what js built-in methods are good for accessing every element in an array and then returning the same number of elements? let's use map

```javascript
const CatIndex = ({ cats }) => {
  return (
    <main>
      {cats?.map((cat, index) => {
        return (
          <>
            <h3 key={index}>{cat.name}</h3>
          </>
        )
      })}
    </main>
  )
}
```

That works but it's not very pretty. if we look back at our wireframe, we had the idea of cards to hold each cat. We added reactstrap for a reason, so let's go checkout the documentation and find something that works for us.

https://reactstrap.github.io/?path=/story/home-installation--page

```html
<Card
  color="secondary"
  style={{
    width: '18rem'
  }}
  key={index}
>
  <img
    alt="Sample"
    src={cat.image}
  />
  <CardBody>
    <CardTitle tag="h5">
      {cat.name}
    </CardTitle>

    <Button>
      Button
    </Button>
  </CardBody>
</Card>
```

add `import { Card, CardBody, CardTitle, Button } from "reactstrap"` to CatIndex.js

to center it:
add <main className="index-cards">

.index-cards {
display: flex;
flex-wrap: wrap;
justify-content: space-around;
}

be sure to import './App.css' in App.js
key={index} should be in the outer tag, won't work on plain react fragment. Need to add React.Fragment in there if you need to use them.


### TESTING CATINDEX 
1. create CatIndex.test.js
2. import RTL & CatIndex
3. Stub out tests

```javascript
import { render } from "@testing-library/react"
import CatIndex from "./CatIndex"

describe("<CatIndex />", () => {
  it("renders without crashing", () => {})
  it("renders cat cards", () => {})
})
```

4. import mockCats.js
 `import mockCats from '../mockCats'`

5. Add content to second test

```javascript
it("renders cat cards", () => {
  const div = document.createElement("div")
  render(<CatIndex cats={mockCats} />, div)
  mockCats.forEach((cat) => {
    const catName = screen.getByText(cat.name)
    expect(catName).toBeInTheDocument()
  })
})
```

### SHOW PAGE

Now let's look at showing one cat's info.  Therefore we will need to pass cats over to CatShow just like we did with CatIndex.

`<Route path="/catshow" element={<CatShow cats={cats} />} />`

Verify CatShow is receiving data

We want to click on this button to see more details - or launch the show page.  
Each cat object has a unique id that can be used to select the correct cat. If we require a param in the url for the CatShow component we can dynamically get an id. Then the show page can only be accessed if a param is passed into the url.

`<Route path="/catshow/:id" element={<CatShow cats={cats} />} />`



```javascript
import React from "react"
import { useParams } from "react-router-dom"

const CatShow = ({ cats }) => {
  const { id } = useParams()
  console.log(id)

  return (
    <>
      <h3>Cat Show Page</h3>
    </>
  )
}

export default CatShow
```

Since we can see the param in the logs, we can use this find the selected cat.  Javascript has a HOF called .find().  It returns the first instance that matches the given criteria.  Here we are looking at all the cat objects to find the id that was passed in the params. 

One last thing - params are always strings. Our id will be a number, so can use the UNARY PLUS to change the data type.  Thank you Javascript! 

```javascript
const { id } = useParams()
let currentCat = cats.find((cat) => cat.id === +id)
console.log(currentCat)
```


final Show:
```javascript
import React from "react"
import { useParams } from "react-router-dom"

const CatShow = ({ cats }) => {
  const { id } = useParams()
  let currentCat = cats?.find((cat) => cat.id === +id)
  return (
       <>
        {currentCat && (
          <>
            <img
              alt={` ${currentCat.name}'s profile`}
              src={currentCat.image}
            />
            <h3>{currentCat.enjoys}</h3>
          </>
        )}
      </>
  )
}


export default CatShow
```

### Testing for CatShow
1. create CatIndex.test.js
2. Copy CatIndex code and paste 
3. Stub out tests
So here we see we used map in CatIndex, but now we're looking at a single cat, so no need for map.
For our test, we can just look at the first cat in the array, so let's pass in a particular cat on which we can make our assertions and we can test paths. This type of test will be a bit trickier than any we've done so far.

Instead of importing BrowserRouter, we will import MemoryRouter from react-router-dom, and we'll also need Routes and Route (remember these are used in App js to provide the paths.) Because of how React Router works, you need to have your components wrapped in a router otherwise all your routing code will throw errors and break. This means even if you want to test a single component, you will need to wrap that component inside of a router or it will throw errors. If you are testing your code in a way that it does not have access to the browser (such as unit testing) then the routers we have talked about so far will throw errors since they all depend on the browser for the URL. The MemoryRouter on the other hand stores all its information in memory which means it never accesses the browser and is ideal when trying to unit test components. Other than this specific use case, though, this router is never to be used.


```javascript
import { render, screen } from "@testing-library/react"
import CatShow from './CatShow'
import { MemoryRouter, Routes, Route } from 'react-router-dom'
import mockCats from '../mockCats'

const renderShow = () => {
  render(
  <MemoryRouter initialEntries={["/catshow/1"]}>
    <Routes>
        <Route path="catshow/:id" element={<CatShow cats={mockCats} />}/>
    </Routes>
  </MemoryRouter>
  )
}
describe("<CatShow />", () => {
  it("renders without crashing", () => {
    renderShow()
  })

  it('renders a card with what the cat enjoys', () =>{
    renderShow()  
    expect(screen.getByText(mockCats[0].enjoys)).toBeInTheDocument()
  })
})
  ```
  We get an error.  
  `TestingLibraryElementError: Unable to find an element with the text: Talking to the dogs walking by. This could be because the text is broken up by multiple elements. In this case, you can provide a function for your text matcher to make your matcher more flexible.`

  Let's checkout the documentation.  We are trying to match a string.  
  https://testing-library.com/docs/queries/about/#textmatch-examples
  
  Looking at the docs, it seems that we can add `{ exact: false }` to the argument.
  add the following to the test:
    `expect(screen.getByText(mockCats[0].enjoys, {exact: false})).toBeInTheDocument()`

  Using this method, we can actually change the text to be:
      `expect(screen.getByText(`${mockCats[0].name} likes ${mockCats[0].enjoys}`, { exact: false})).toBeInTheDocument()`

We then want to connect the show page and index page so that you can click on the button on the index page and get the show page of that cat.

in INDEX:

`import { NavLink } from "react-router-dom"`

<NavLink to={`/catshow/${cat.id}`} className="nav-link">
  See More Details
</NavLink>

