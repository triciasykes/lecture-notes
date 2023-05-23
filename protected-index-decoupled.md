# Creating Protected Index for the decoupled app

##  First we will revisit the current setup and structure:

```javascript
import {Route, Routes } from 'react-router-dom'
import Home from './pages/Home'
import ApartmentIndex from './pages/ApartmentIndex'
import ApartmentShow from './pages/ApartmentShow'
import ApartmentNew from './pages/ApartmentNew'
import MyApartments from './pages/MyApartments'
import ApartmentEdit from './pages/ApartmentEdit'
import Header from './components/Header'
import Footer from './components/Footer'
import NotFound from './pages/NotFound'
import mockUsers from './mockUsers'
import mockApartments from './mockApartments'


import './App.css'

const App = () => {
  
  return(
    <>
      <Header />
      <Routes>
        <Route path="/" element={<Home />} />
        <Route path="/apartmentindex" element={<ApartmentIndex  />} />
        <Route path="/apartmentshow/:id" element={<ApartmentShow />} />
        <Route path="/apartmentnew" element={<ApartmentNew />} />
        <Route path="/apartmentedit" element={<ApartmentEdit />} />
        <Route path="/myapartments" element={<MyApartments/>} />
        <Route path="*" element={<NotFound/>} />

      </Routes>
      <Footer />
    </>
  )
}

export default App;
```

We will also want to create two additional components => Login and SignUp.  Add them to the Routes and import.  We won't actually be able to use the log in and sign up pages yet, but we can 

```javascript
//add the following:
        <Route path="/login" element={<Login />} />
        <Route path="/signup" element={<SignUp />} />
// complete routes:        

     <Header />
      <Routes>
        <Route path="/" element={<Home />} />
        <Route path="/login" element={<Login />} />
        <Route path="/signup" element={<SignUp />} />
        <Route path="/apartmentindex" element={<ApartmentIndex apartments={apartments}/>} />
        <Route path="/apartmentshow/:id" element={<ApartmentShow />} />
        <Route path="/apartmentnew" element={<ApartmentNew />} />
        <Route path="/apartmentedit" element={<ApartmentEdit />} />
        <Route path="/myapartments" element={<MyApartments/>} />
        <Route path="*" element={<NotFound/>} />
      </Routes>
      <Footer />
    </>
  ```

and then also add these to Navigation.js

```javascript
  <NavItem>
    <NavLink to="/login" className="nav-link">
      Sign In
    </NavLink>
  </NavItem>
  <NavItem>
    <NavLink to="/signup" className="nav-link">
      Sign Up
    </NavLink>
  </NavItem>
```        



We have our state objects.  We will need to create state for both user and apartments.  Thinking about how a typical site works, and thinking about sessions that devise will eventually provide, we are going to want to know the status of the current user - are they logged in or not.  While we can't really transition on a click with mockData, we can change our currentUser to null to represent user is not logged in and then using bracketNotation, we can isolate one user to show logged in.  This general setup will also set us up for success when we connect to backend. 

`const [currentUser, setCurrentUser] = useState(mockUsers[0])`

and if I console.log currentUser I can see I get just one user. Perfect.

Now we also want to show the index of all the apartments to weather or not the person is logged in, so let's create another state variable for our apartments.  Here we want all of them, so let's pass in the mockApartments.
`cosnt [apartments, setApartments] = useState(mockApartments)`

console.logging shows us we have access to all our apartments.  Great.
 
 Show off Index with data passing through. Ok.  

 Now that we have a list of all of our apartments rendering, as a signed in user, we may want to be able to see only the listings that we have created as well. This page will be protected so that only a logged in user can access this page.

For this, we need to consider what information is needed here. We will need apartments of course, but we will also want to check that our current user is the same as the one who created the apartments.

When setting up our backend, we created a has_many belongs_to association, so apartment belongs to user. If we look at our schema, we see that apartment has a foreign key of user_id. This is helpful information that we can use to perform an evaluation of whether or not our current user's id is the same as the one on the foreign key. (current_user.id === apartment.user_id)

To set this up, let's start off by RENAMING ApartmentProtectedIndex to something more meaningful - MyApartments
UPDATE NAME TO MyApartment.js, change component name.  Copy over Index.js


Then App.js and update our route. We will certainly need apartments from state, but we are also going to need information on what the current user is

```javascript
 <Route path="/myapartments" element={<MyApartments current_user={current_user} apartments={apartments} />} />


const MyApartments = ({apartments, current_user}) => {
  console.log("apartments", apartments)
  console.log("current_user", current_user)
  return (
    <>
      <h1>My Listings</h1>
      ...
    </>
  )
}
```
Since we have access to props, now we need to sift through the apartments and search for only the apartments that have a user_id of current_user.id. For this, let's use filter.

``` javascript
import React from "react"
import {
  Card,
  CardBody,
  CardTitle,
  CardSubtitle,
  Button,
} from "reactstrap"
import { NavLink } from "react-router-dom"

const MyApartments = ({ current_user, apartments }) => {
  
  const myApartments = apartments?.filter(
    (apartment) => current_user?.id === apartment.user_id
  )

  return (
    <>
      <div className="apartments-body">
        <h1 className="index-title">Recent Listings</h1>
        <div className="flex-apartments">
          {myApartments.map((apartment, index) => {
            return (
              <Card
                style={{
                  width: "14rem",
                }}
                key={index}
              >
                <img alt={`apartment exterior view`} src={apartment.image} />
                <CardBody>
                  <CardTitle tag="h5">${apartment.price}/month</CardTitle>
                  <CardSubtitle>
                    {apartment.street}, {apartment.city}, {apartment.state}
                  </CardSubtitle>
                  <CardSubtitle>
                    {apartment.bedrooms} Bedroom, {apartment.bathrooms} Bath
                  </CardSubtitle>
                  <CardSubtitle>
                    Pets: {apartment}>
                  </CardSubtitle>
                  <NavLink
                    to={`/apartmentshow/${apartment.id}`}
                    className="nav-link"
                  >
                    <Button className="apartment-button">More Details</Button>
                  </NavLink>
                </CardBody>
              </Card>
            )
          })}
        </div>
      </div>
    </>
  )
}

export default MyApartments

and we want to also add a link to my listings to the navigation:
```javascript
  <NavItem>
    <NavLink to="/myapartments" className="nav-link">
      My Listings
    </NavLink>
  </NavItem>
```

```javascript
// ApartmentShow

....
      <CardSubtitle>Pets: {currentApartment.pets}</CardSubtitle>
    </div>

// add the following:
  
  {current_user && current_user.id === currentApartment.user_id &&
      <div className="show-button">            
      <NavLink to={`/apartmentedit/${currentApartment.id}`} className="nav-link edit-listing">
        <Button className="apartment-button">
            Edit Listing
        </Button>
      </NavLink>
      <NavLink to={`/myapartments`} className="nav-link">
        <Button onClick={() => deleteApartment(currentApartment.id)} className="apartment-button">
            Delete Listing
        </Button>
      </NavLink>
    </div> 
    
    </div>
    ...
  }



### Navigation


{current_user && (
          <>
            <NavItem>
              <NavLink to="/myapartments" className="nav-link">My Listings</NavLink>
            </NavItem>
            <NavItem>
              <NavLink to="/apartmentnew" className="nav-link">Create Listing</NavLink>
            </NavItem>
            <NavItem>
              <NavLink to="/" className="nav-link">Log Out</NavLink>
            </NavItem>
          </>
        )}
        {!current_user && (
          <>
            <NavItem>
              <NavLink to="/login" className="nav-link">
                Sign In
              </NavLink>
            </NavItem>
            <NavItem>
              <NavLink to="/signup" className="nav-link">
                Sign Up
              </NavLink>
          </NavItem>
          </>
        )}