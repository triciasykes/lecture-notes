# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version
# React External API

# Lecture Notes

### Process
- Ensure you are in the cohort-lecture-examples repo
- Ensure your local is up to date and there are no stale branches
- Create a new branch
- Create a React project with the naming convention `framework-topic`
  $ yarn create react-app external-api-fetch
  $ cd my-app
  $ yarn start
- Run the project with `yarn start`

### Additional Notes and Goals

- Is an interface that is designed to be worked with by OTHER PROGRAMS
- Is super helpful for devs to share data from around the Internet.
- it is NOT a UI // User Interface
- Is an interface that is designed to be worked with by humans or human like beings
- It helps us make really cool UI's by populating data for our users


** Notes to type**
Fetch - a tool that allows for asynchronous requests
- Javascript is single threaded- only does one thing at a time
- Fetch allows the app to multitask
- Fetch - sends a request and waits for a response
- Fetch returns a Promise
- A Promise has three states: pending, fulfilled, rejected

Diagram for Promise: https://javascript.info/promise-basics

#### Promises
Fetch is a way to make asynchronous requests. When you send out a request and specify that it is going to be asynchronous, what you get back is a Promise. Promises represent the eventual completion (or failure) of an asynchronous operation. Promises will return either the payload of data or an error. A Promise is basically a proxy for a value not yet known. A Promise says, "I will definitely give you back something. I just have no way of knowing if it will succeed or fail or how long it will take."


- Promises are JavaScript objects
- Promises are in one of three states: pending, fulfilled, rejected

#### Fetch
To explore the fetch syntax, we are going to use a really simple API. [IP address location]"https://ipapi.co/api/?shell#location-of-clients-ip"

This API has the sole purpose of returning the IP address of the device that is making the request.  What it returns is an object as we can see in this example.  We can copy the URL under example and see that we are getting back json, which is exactly what we want.  We are now going to make a really simple app around this API.

** Setup functional component in App.js

- React app is going to make a request to the external API
- Need to store the data in the component
- Render the data to the page

- Fetch is a method that takes the argument of a URL
- Fetch is followed by a series of methods that are higher-order functions to handle the response

```javascript
const App = () => {
  const [ipAdress, setIpAddress]

    const getIp = () => {
    fetch('https://ipapi.co/json/')
    .then(response => response.json())
    .then(payload => setIpAddress(payload))
    .catch(error => console.log(error))
  }
  
  render(){
    return(
      <>
        <h1>Find Your IP Address</h1>
        <button onClick={getIp}>Click here to see your IP Address</button>
        <p>IP: {ipAddress.ip}</p>
      </>
    )
  }
}
  ```

  ```javascript
  // First - Make sure the function works.
  const getIp = () => {
    alert("yo") // step 1
  }


  // Second - This is the very simplest use of fetch. Passing an argument of API endpoint you want to fetch and returns a promise containing the response.  Dot then is going to be chained onto our fetch so that we can then do something specific with our response, and we can chain .then multiple times.  Dot then is a higher order function that's job is simply to handle the response.  Let's console log what the response is first.
  getIp = () => {
    fetch("https://ipapi.co/json/")
    .then(response => console.log(response))
  }

  // Third - The object is just an HTTP response. To extract the JSON body content from the response, we use the .json() method and we can see the promise object.
  getIp = () => {
    fetch("https://ipapi.co/json/")
    .then(response => console.log(response.json()))
  }

  // Fourth - Once the promise is fulfilled we can handle the payload.
  getIp = () => {
    fetch("https://ipapi.co/json/")
    .then(response => response.json())
    .then(payload => console.log(payload))
  }

  // Fifth - Once we can see the payload being logged the next step is setting the data to state.
  getIP = () => {
    fetch("https://ipapi.co/json/")
    .then(response => response.json())
    .then(payload => setIpAddress({ipAddress: payload}))
  }

  // Sixth - Catch is like an else statement that can log any errors we get.
  getIP = () => {
    fetch("https://ipapi.co/json/")
    .then(response => response.json())
    .then(payload => setIpAddress({ipAddress: payload}))
    .catch(error => console.log(error))
  }
```


#### NASA API Scaffold
- Not all APIs are created equally
The NASA API has super cool information and it gives us a test run at the data. No matter what, storing data costs money. And accessing that stored data cost money. So it is common for developers to limit the number of API calls (or requests) that can be made to a server. That way, whoever owns the data stays in change of who can access it and can control the amount of traffic to prevent overwhelming the server.

Remember that every time you make a request, you get a response, even if that response is an error. A malicious person could have a bunch of computers pinging a web server thousands and thousands of times a second and back up the server. All the requests will get answers, but if the server is answering slower than the requests are coming in a queue will start to form. This can create a situation where normal users will try and use the site and it will look like it is down because that request is behind so many others. When this is done intentionally to cause harm it is called a DDOS attack - or distributed denial of service attack.

To prevent this from happening, developers will ask users of their API to register so that they can put a limit on the number of requests made by a single app. This is usually done in the form of an API key. A key will be a token that is added to the URL in the fetch request.
- An API key is tied directly to you and therefore should never be stored on GitHub.  There are ways to hide the API key that we will go through later, but for now let's just start with building the application using the data from the demo key.

- Put the data provided from demo key into a local file to allow us to mock the data while building out the application.
- Make sure the logic works
- Then make the fetch request
- [Nasa API](https://api.nasa.gov/)

```javascript
// File - src/mockNasa.js
// let nasaData = .....
// export default nasaData
// beautify or prettier 

import React, { useState } from 'react'
import mockNasa from './mockNasa'

const App = () => {

  const [nasaData, setNasaData] = useState(mockNasa)
  const getPic = () => {
    let data = mockNasa.photos
    let randomNum = Math.floor(Math.random() * data.length)
    setNasaData( data[randomNum].img_src)
  }
 
    return(
      <>
        <h1>Mars Rover Pic</h1>
        <button onClick={getPic}>Click here</button>
        <br />
        {nasaData &&
            <img style={{height: "200px"}} src={nasaData} alt="random Mars Rover" />
        }
      </>
    )
  }

  export default App
```

#### NASA API Fetch
Now that the app is working correctly it is time to fetch live data.  Ultimately, I have set this up so that I set all the data once inside of state, and the button only cycles through the stored data in state.  This will make it so I only need to do one fetch call initially when I load my page, set it the data to state and then cycle through it when clicking the button.  To do this, I will use my friend componentDidMount that allows us to perform whatever we want when our page is loading.  

This seems like a really great place for us to place our fetch since we want to update our state only when we initially load our page.  


- Make an account with NASA
- Generate an API key
- Start with adding it directly to the URL
- [Hiding API Keys](https://www.pluralsight.com/guides/hiding-secret-keys-in-create-react-app)
- Create an .env file and add it to .gitignore
- add `gem "dotenv-rails"` to Gemfile!
- REACT_APP_API_KEY = "key here"
- Update fetch call
- ** Will need to restart server **

```javascript
// First - Add the key directly to the URL.

  fetch("https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos?sol=1500&api_key=long-string-of-characters-here")
  .then(response => response.json())
  .then(payload => {
    console.log(payload)
    this.setState({nasa: payload.photos, pic: payload.photos[0].img_src})
  })
  .catch(error => console.log(error))
}
```




```javascript
// Second - Replace the key with an environment variable.
import React, { useState } from 'react'


  const App = () => {
    // somewhere to store local data
    const [nasaData, setNasaData] = useState("")
  
    const apiKey = process.env.REACT_APP_API_KEY
  
    const nasaFetch = () => {
      fetch(`https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos?sol=1000&api_key=${apiKey}`)
      .then(response => response.json())
      .then(payload => setNasaData(payload))
      .catch(errors => console.log(errors))
    }
  
    // My components display
    return (
      <>
        <h1>Mars Rover Pictures</h1>
        <button onClick={nasaFetch}> Click me!</button>
  
        {nasaData && nasaData.photos.map((obj, index) => {
          return <img src={obj.img_src} alt="" key={index} />
        })}
  
      </>
    )
  }

  export default App
```

### Review
- What are APIs? Websites that store data.
- How can you access an API? With a fetch request.
- What does fetch return? A promise.
- What are the three states of a promise? Pending, rejected, fulfilled.
- What is an API key?
- How do you protect your API key? Don't push it to GitHub, use an .env file.
- How do you know if you have found a "good" API or a "bad" one? You don't. You have to read the docs and test it out.

### Next Steps
- Open the syllabus section and briefly run through the challenges and expectations
- Remind the student to use the `react-challenges` repo
- Remind the students of the appropriate naming conventions for their branch and file
- Post pairs in Slack
- Open breakout rooms with ability for participants to choose their room

