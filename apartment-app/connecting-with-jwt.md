# Apartment App Connecting Authentication with JWT

As of right now, our frontend application is reliant on mock data to display information, however we do want this application to be connected to a database. In Cat Tinder, we explored fetch which allowed us to make a request to our API. We are once again going to utilize fetch to consume our data, however, this time we also need to be gathering our token when a user is signed in which will be the main focus of this lecture.

### Connecting React and Rails API

When we are dealing with user credentials we do need to make sure we are thoughtful about how that data is passed between applications. When a user first signs up, we need to send their username and password to the Rails API where it will be stored as a new instance in the database. To authenticate an existing user (log in) we need to send the user's email and password to the Rails API and perform a check against existing users in the database. If the credentials match, a token will be created and passed back to the React application. This token remains valid during the current user session and will authorize the user to see certain protected pages. Once the user logs out the session token is revoked.

### Initial State Variables

First we need to update App.js to remove our mock user and set our default to no user being logged in (null). We can also update our apartment array to an empty array which will later be updated in our fetch call.

**src/App.js**

```javascript
const App = () => {
  const [currentUser, setCurrentUser] = useState(null)
  const [apartments, setApartments] = useState([])

  return (
    // existing code ...
  )
}
```

### Collect Input Data

Next we need to handle the view for a user to sign up or log in. There is a really neat React hook that can help us setup our form quickly called useRef.

**useRef** is a React hook that allows us to access elements from the DOM and persist those values between renders. With `useRef` we can create a reference to our sign up and log in forms then access the values entered in those form fields as needed by using the `current` property.

- Updating a reference doesn't trigger re-rendering, while updating the state makes the component re-render
- The reference update is synchronous (the updated reference value is available right away), while the state update is asynchronous (the state variable is updated after re-rendering).

We can grab all the input values with `formRef.current`.

**src/pages/Signup.js**

```javascript
// Don't forget your import
import { useRef } from "react"

const Signup = () => {
  // First, create a variable using useRef. We want to get the input values from the signup form so we'll name the variable 'formRef'
  const formRef = useRef()

  const handleSubmit = () => {
    console.log("Sign Up")
  }

  return (
    <div>
      {/* Next, use the property `ref` to attach the variable to the form you want to target. */}
      <form ref={formRef} onSubmit={handleSubmit}>
        Email: <input type="email" name="email" placeholder="email" />
        <br />
        Password:{" "}
        <input type="password" name="password" placeholder="password" />
        <br />
        Confirm Password:{" "}
        <input
          type="password"
          name="password_confirmation"
          placeholder="confirm password"
        />
        <br />
        <input type="submit" value="Submit" />
      </form>
      <br />
      <div>
        Already registered, <a href="/login">Login</a> here.
      </div>
    </div>
  )
}
export default Signup
```

#### Packaging Form Data

Now that we have a way to access the user inputs, we need to package the data in a format `JWT` recognizes. For this we will use a JavaScript object called `FormData`.

**FormData** allows us to build and manipulate HTML form data before sending it to the Rails API. `FormData` creates objects containing form fields (keys) and their values(input).

We can pass in `formRef.current` as an argument when creating a new `FormData`, then use `Object.fromEntries` to access the values. We will do all of this in a `handleSubmit` function that is linked to the submit form button.

**src/pages/Signup.js**

```javascript
const handleSubmit = (e) => {
  // preventDefault stops the default behavior of reloading or refreshing the form so we can send the data with fetch
  e.preventDefault()
  // store the form entries in a variable
  const formData = new FormData(formRef.current)
  // create an object from the entries
  const data = Object.fromEntries(formData)
  // store user's info in format that can be used with JWT
  const userInfo = {
    user: { email: data.email, password: data.password },
  }
}
```

### Login and Signup Functions

Inside our fetch for user authentication, we need to store the token created by JWT. **localStorage** allows us to store key-value pairs in the form of strings and provides methods to store, retrieve, and remove the token locally in the user's browser. The data stored remains available even after the user closes the browser or navigates away from the website.

The localStorage property comes with four basic methods:

- `localStorage.setItem(key, value)`: Stores a value in `localStorage`. The key is a unique identifier for the data, and the value is the actual data you want to store. Both the key and value must be strings.
- `localStorage.getItem(key)`: Retrieves the value associated with a given key from `localStorage`. It returns null if the key does not exist.
- `localStorage.removeItem(key)`: Removes the item associated with the specified key from `localStorage`.
- `localStorage.clear()`: Removes all items stored in `localStorage`, effectively clearing the entire storage.

**Note**: Data must be stored as strings. When dealing with data structures such as objects or arrays we will need to convert them to strings using JSON.stringify() before storing. It is also necessary to parse them back to their original format using JSON.parse() when retrieving from `localStorage`.

We can now use these methods to access our JWT in the fetch requests for sign up, log in, and log out.

**src/App.js**

```javascript
// authentication methods
const login = (userInfo) => {
  fetch(`${url}/login`, {
    body: JSON.stringify(userInfo),
    headers: {
      "Content-Type": "application/json",
      Accept: "application/json",
    },
    method: "POST",
  })
    .then((response) => {
      if (!response.ok) {
        throw Error(response.statusText)
      }
      // store the token
      localStorage.setItem("token", response.headers.get("Authorization"))
      return response.json()
    })
    .then((payload) => {
      setCurrentUser(payload)
    })
    .catch((error) => console.log("login errors: ", error))
}

const signup = (userInfo) => {
  fetch(`${url}/signup`, {
    body: JSON.stringify(userInfo),
    headers: {
      "Content-Type": "application/json",
      Accept: "application/json",
    },
    method: "POST",
  })
    .then((response) => {
      if (!response.ok) {
        throw Error(response.statusText)
      }
      // store the token
      localStorage.setItem("token", response.headers.get("Authorization"))
      return response.json()
    })
    .then((payload) => {
      setCurrentUser(payload)
    })
    .catch((error) => console.log("login errors: ", error))
}

const logout = () => {
  fetch(`${url}/logout`, {
    headers: {
      "Content-Type": "application/json",
      Authorization: localStorage.getItem("token"), //retrieve the token
    },
    method: "DELETE",
  })
    .then((payload) => {
      localStorage.removeItem("token") // remove the token
      setCurrentUser(null)
    })
    .catch((error) => console.log("log out errors: ", error))
}
```

Now we can pass these functions into their components and call them when a user clicks sumbit

**src/App.js**

```javascript
<Header current_user={currentUser} logout={logout} />
<Routes>
  <Route path="/" element={<Home />} />
  <Route path="/login" element={<Login login={login} />} />
  <Route path="/signup" element={<Signup signup={signup}/>} />
  {/* other routes... */}
```

**src/pages/Signup.js**

```javascript
const handleSubmit = (e) => {
  {
    /* ... */
  }

  signup(userInfo)
  navigate("/")
  e.target.reset() // resets the input field
}
```

**src/components/Header.js**

```javascript
import { useNavigate } from "react-router-dom"

const navigate = useNavigate()

const handleClick = () => {
  logout()
  navigate("/")
}
```

** Hint** May need to add this to application controller:

```ruby
class ApplicationController < ActionController::Base
  skip_before_action :verify_authenticity_token
end
```

### Persist Current User

Having the initial state of `currentUser` set to `null` will cause the user to be logged out if the user manually refreshes the browser. To solve this problem we can create a function that checks if a JWT exists and set the state to the logged in user if it does. This function will live in the `useEffect` hook.

**src/App.js**

```javascript
useEffect(() => {
  const loggedInUser = localStorage.getItem("user")
  if (loggedInUser) {
    setCurrentUser(JSON.parse(loggedInUser))
  }
  readApartments()
}, [])
```

Code for Login:

```javascript
import { useRef } from "react"
import { useNavigate } from "react-router-dom"

const Login = ({ login }) => {
  const formRef = useRef()
  const navigate = useNavigate()

  const handleSubmit = (e) => {
    e.preventDefault()
    const formData = new FormData(formRef.current)
    const data = Object.fromEntries(formData)
    const userInfo = {
      user: { email: data.email, password: data.password },
    }
    login(userInfo)
    navigate("/")
    e.target.reset()
  }
  return (
    <div className="auth-body">
      <h2 className="header">Login</h2>
      <form className="form-div" ref={formRef} onSubmit={handleSubmit}>
        Email:{" "}
        <input
          className="field auth-flex"
          type="email"
          name="email"
          placeholder="email"
        />
        <br />
        Password:{" "}
        <input
          className="field auth-flex"
          type="password"
          name="password"
          placeholder="password"
        />
        <br />
        <input className="actions" type="submit" value="Login" />
        <div className="links">
          Not registered yet?
          <a href="/signup">
            {" "}
            <u>Signup</u>
          </a>
        </div>
      </form>
    </div>
  )
}
export default Login
```
