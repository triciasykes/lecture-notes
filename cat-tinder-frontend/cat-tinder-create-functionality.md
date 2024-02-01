### Cat Tinder Create Functionality Lecture Notes

Today we will be working on our create functionality. To see what our task requirements are for this, we will start by heading over to trello and bringing the card over to in progress.

I also want to head to the syllabus and bring in the developer stories and place them in my notes so I can keep track of what I am doing.

We can see that we will need to store information in state, then pass it on back to App.js so later we can update our cat. We will also need test coverage for this.

We have 7 RESTful routes: index, show, create, new, update, edit, destroy

Only 2 of these are simply a form, which is React's job this time around:

New - RESTful route that displays a form Edit - RESTful route that displays a form

In this lecture we will focus on NEW.

## Create the Form

We know we need a form, so let's head over to Reactstrap to find something that suits our needs.  
https://reactstrap.github.io/?path=/story/home-installation--page

- take from stories - copy just one input form group

```javascript
<Form>
  <FormGroup>
    <Label for="exampleEmail">Email</Label>
    <Input
      id="exampleEmail"
      name="email"
      placeholder="with a placeholder"
      type="email"
    />
  </FormGroup>
</Form>
```

Copy this 3x and adjust the data to fit our structure
Add Submit Button - pull from reactstrap same form

```javascript
<Button>Submit</Button>
```

## Create State

```javascript
import { useState } from 'react'
import { Form, FormGroup, Input, Label, Button } from 'reactstrap'


const CatNew = () => {
  // Since we are waiting for information from our user, we will set up state to look like how our database is structured but set the keys in the object to be empty strings temporarily.  This will later get updated, but for now, we just need to give state some structure to follow.

  const [newCat, setNewCat] = useState({
    name: "",
    age: "",
    enjoys: "",
    image: ""
  })
  return (
    ...the form...
  )
```

Now we need a way to grab the inputs and store them in state. We can use our eventListeners to do this. In this case,
we'll want to listen for a change. Let's start by defining our method
Remember e.target.value allows us to access the input as it's being typed. Then we want to update the state object with these new values.

```javascript
const handleChange = (e) => {
  // Spread operator makes a copy of our state object
  // e.target.name will be telling us which key we are updating based on the name in input
  // e.target.value will be telling us what value you are setting to that key
  setNewCat({ ...newCat, [e.target.name]: e.target.value })
}
```

Then we need to add this method to each of our inputs, as well as the value of our new state, in this case newCat

```javascript
<Input
  name="name"
  placeholder="Cat's name"
  type="text"
  onChange={handleChange}
  value={newCat.name}
/>
// update all other Inputs
```

## Pass State from CatNew to App.js

Now that we have a form and are able to grab data, we need to pass the data upstream to App.js. We will need to use our friend functional props.

Just a note - our new cat will not show up on our index page because that data is stored in a js file, mockCats, which can't be updated. But we can console log to make sure the data is passed. Tomorrow we will connect the frontend and backend and will be able to use real data from the data base. Right now, we are just prepping the frontend to align with what our backend is expecting.

So, to pass the new cat data to App.js, we will need to create a function in App.js. We'll call it createCat.

```javascript
// App.js
const createCat = (cat) => {
  console.log("Created cat", cat)
}
```

Since our submit button is on CatNew, we need to pass this function down to the component as props so we can call this function.

```javascript
// App.js
<Route path="/catnew" element={<CatNew createCat={createCat}/>}>
```

Now I need to call this function in CatNew. So we can create another function called handleSubmit that will invoke our createCat function.

```javascript
const handleSubmit = () => {
  createCat(newCat)
}
```

Now we can use our onClick method to invoke the handleSubmit function.

```javascript
<Button onClick={handleSubmit} name="submit">
  Submit
</Button>
```

## Redirect to CatIndex

Now thinking from a UX perspective, right now the user has no idea if their input was submitted successfuly. We'll want to redirect to the index page so we can see our new cat added to the list of cats.

React has a hook to help us called useNavigate. This helps us to navigate programmatcially - for instance, redirect a form.

First we need to import {useNavigate} from 'react-router-dom' into CatNew

```javascript
const CatNew = ({ createCat }) => {
  // store useNavigate in a variable called navigate
  const navigate = useNavigate()

  //... state
  // handleChange

  const handleSubmit = () => {
    createCat(newCat)
    navigate("/catindex")
  }
}
```

## Cat New Test with RTL

```javascript
import { screen, render } from "@testing-library/react"
import CatNew from "../pages/CatNew"
import { BrowserRouter } from "react-router-dom"

describe("<CatNew />", () => {
  it("renders a new cat form", () => {
    render(
      <BrowserRouter>
        <CatNew />
      </BrowserRouter>
    )
    const nameInput = screen.getByRole("textbox", { name: /name/i })
    expect(nameInput).toBeInTheDocument()
    const enjoysInput = screen.getByRole("textbox", { name: /enjoys/i })
    expect(enjoysInput).toBeInTheDocument()
  })
  // we can also test that that we have not made any mistakes on our form

  it("has a form with entries for name, age, enjoys and image", () => {
    const formName = screen.getByText(/name/i)
    expect(formName.getAttribute("For")).toEqual("name")

    const formAge = screen.getByText("Age")
    expect(formAge.getAttribute("For")).toEqual("age")

    const formEnjoys = screen.getByText(/enjoys/i)
    expect(formEnjoys.getAttribute("For")).toEqual("enjoys")

    const formImage = screen.getByText(/image/i)
    expect(formImage.getAttribute("For")).toEqual("image")
  })
})
```

## Final New Cat Component

```javascript
import { useState } from "react"
import { useNavigate } from "react-router-dom"
import { Form, FormGroup, Input, Label, Button } from "reactstrap"

const CatNew = ({ createCat }) => {
  const navigate = useNavigate()
  const [newCat, setNewCat] = useState({
    name: "",
    age: "",
    enjoys: "",
    image: "",
  })
  const handleChange = (e) => {
    setNewCat({ ...newCat, [e.target.name]: e.target.value })
  }

  const handleSubmit = () => {
    createCat(newCat)
    navigate("/catindex")
  }
  return (
    <Form>
      <FormGroup>
        <Label for="cat-name" hidden>
          Name
        </Label>
        <Input
          id="cat-name"
          name="name"
          placeholder="Cat's Name"
          type="text"
          value={newCat.name}
          onChange={handleChange}
        />
      </FormGroup>{" "}
      <FormGroup>
        <Label for="cat-age" hidden>
          Age
        </Label>
        <Input
          id="cat-age"
          name="age"
          placeholder="Cat's Age"
          type="text"
          value={newCat.age}
          onChange={handleChange}
        />
      </FormGroup>
      <FormGroup>
        <Label for="cat-enjoys" hidden>
          Enjoys
        </Label>
        <Input
          id="cat-enjoys"
          name="enjoys"
          placeholder="What does your cat enjoy?"
          type="text"
          value={newCat.enjoys}
          onChange={handleChange}
        />
      </FormGroup> <FormGroup>
        <Label for="cat-image" hidden>
          Picture
        </Label>
        <Input
          id="cat-image"
          name="image"
          placeholder="Add a picture of your cat"
          type="text"
          value={newCat.image}
          onChange={handleChange}
        />
      </FormGroup> <Button type="submit" onClick={handleSubmit}>
        Submit
      </Button>
    </Form>
  )
}

export default CatNew
```
