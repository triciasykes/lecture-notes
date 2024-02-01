# Protected Index

As a signed in user, we may want to be able to see only the cat listings that we have created as well. This page will be protected so that only a logged in user can access this page.

Like we did before, we are going to start by using mock data to make sure this all works before connecting.
We should have a mockCats.js file, so let's just add a mockUsers.js file first to make sure everything works before we connect it with the backend.

```javascript
let mockUsers = [
  {
    id: 1,
    email: "test1@example.com",
  },
  {
    id: 2,
    email: "test2@example.com",
  },
  {
    id: 3,
    email: "test3@example.com",
  },
]

export default mockUsers
```

We will also now need to add a user_id to each mockCat.
Only one user will be logged into the application at a time, and during the mock stage we can hardcode the the user to be lets say mockUser[0]. For this we need state!

`const [currentUser, setCurrentUser] = useState(mockUser[0])`

We need to consider what information is needed here. We will need cats of course, but we will also want to check that our current user is the same as the one who created the cats.

When setting up our backend, we created a has_many belongs_to association, so cat belongs to user. If we look at our schema, we see that cat has a foreign key of user_id. This is helpful information that we can use to perform an evaluation of whether or not our current user's id is the same as the one on the foreign key. (currentUser.id === cat.user_id)

To set this up, let's start off in App.js and update our route. We will certainly need cats from state along with the current user.

We also will want to make it so this particular route can only be accessed if a user is signed in. For this, we will conditionally render the route.

```javascript
{
  currentUser && (
    <Route
      path="/mycats"
      element={<MyCatIndex currentUser={currentUser} cats={cats} />}
    />
  )
}
```

Now that we are passing these to MyCatIndex, we need to create the page MyCatIndex.js.

```javascript
const MyCatIndex = () => {
  return (
    <>
      <h2> My Cats </h2>
    </>
  )
}

export default MyCatIndex
```

let's check that we have access to those props.

```javascript
const MyCatIndex = ({ cats, currentUser }) => {
  console.log("cats", cats)
  console.log("currentUser", currentUser)
  return (
    <>
      <h1>My Cats</h1>
    </>
  )
}
```

Since we have access to props, now we need to sift through the cats and search for only the cats that have a user_id of currentUser.id. For this, let's use filter.

```javascript
const MyCatIndex = ({ currentUser, cats }) => {
  const myCats = cats?.filter((cat) => currentUser.id === cat.user_id)

  return (
    <>
      <h1>My Cats</h1>
    </>
  )
}

export default MyCatIndex
```

Since we are storing the array of filtered cats to a variable, we can now iterate on our filtered cats and display the content.

We want this page to look just like our index page, just with only the user's listings, so we can use the same structure we did in CatIndex and reuse the styling as well. Well that sounds like rewriting something we already did - why would we do that? Let's just add the Card structure and styling as a new Component! Due to the naming used with Reactstrap, Card is taken. So let's call it CatCard.js. and we can cut out the structure from CatIndex and put it in this new component.

```javascript
import { Card, CardBody, CardTitle, CardSubtitle } from "reactstrap"
import { NavLink } from "react-router-dom"

const CatCard = ({ cat, index }) => {
  return (
    <Card
      color="light"
      style={{
        width: "18rem",
      }}
      key={index}
    >
      <img alt="cat profile" src={cat.image} />
      <CardBody>
        <CardTitle tag="h4">{cat.name}</CardTitle>
        <CardSubtitle className="mb-2 text-muted" tag="h6">
          {cat.age}
        </CardSubtitle>

        <NavLink to={`/catshow/${cat.id}`} className="nav-link">
          Details
        </NavLink>
      </CardBody>
    </Card>
  )
}

export default CatCard
```

```javascript
import React from "react"
import {
  Card,
  CardImg,
  CardText,
  CardBody,
  CardTitle,
  CardSubtitle,
  Button,
} from "reactstrap"
import { NavLink } from "react-router-dom"

const MyCats = ({ currentUser, cats }) => {
  const myCats = cats?.filter((cat) => currentUser.id === cat.user_id)

  return (
    <>
      <div className="cats-body">
        <h1>My Cats</h1>
        <div className="flex-cats">
          {myCats?.map((cat, index) => {
            return <CatCard cat={cat} index={index} />
          })}
        </div>
      </div>
    </>
  )
}

export default MyCatIndex
```

Now let's work on testing. As we have in the past, we have to make sure that any information that is being called on in the component is also being passed to our test when we render the component. In this case, we need cats, that we can use mockCats for, and also create an object that will be current user for us to use.

```javascript
import React from "react"
import { render, screen } from "@testing-library/react"
import MyCats from "./MyCats"
import { BrowserRouter, useParams } from "react-router-dom"
import mockCats from "../mockCats"

describe("<MyCats />", () => {
  beforeEach(() => {
    const currentUser = {
      email: "test@test.com",
      password: "testing123",
      id: 1,
    }
    const userCats = [
      {
        name: 'Tuesday',
        age: 20,
        enjoys: 'Staring at you your soul with his giant eyes'
        image: 'https://i.pinimg.com/736x/6d/1d/a9/6d1da9f9dcecbefc73bb620bef2f1c07.jpg'
        user_id: 1,
      },
    ]
    render(
      <BrowserRouter>
        <MyCats currentUser={currentUser} myCats={userCats} />
      </BrowserRouter>
    )
  })

  it("renders without crashing", () => {
    const element = screen.getByText("My Cats")
    expect(element).toBeInTheDocument()
  })
})
```
