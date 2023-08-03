# Functional Props Lecture Notes

We discussed React Props yeterday and we learned that we can send props downstream from Parent component to Child component. But what do we do when we need to send data from Child to Parent?
This is where **functional props** come in.

In my terminal I'm in the bravo-lecture-notes repo on the main branch.

- `$ git pull origin main`
- `$ git branch`
- delete any stale branches `git branch -d <branch-name>`
- `$ git checkout -b functional-props`

Let's create a react app!

- `$ yarn create react-app functional-props`
- `$ cd functional-props`
- `$ yarn start`

Everything is working. It's good practice to keep the server running and browser open while developing a React app. This will allow you see your changes immediately and prevents you from having to find an error multiple steps back from your last addition of code. It's a huge timesaver to check the browser after every change. Best to keep both your editor and browser open on the same screen.

- `$ code .`
- delete all of App.js and App.css

## Project

Yesterday, Sarah walked you through creating a podcast clone. Today we are going to make another clone - Netflix.
The final product will be the interface with a list of shows & movies, plus the ability to like a particular item show/movie. When we like an item, a heart will show up on that specific card. We are going to walk through this step by step. The first part will be review of passing props downstream, so let's get started.
_src/App.js_

```javascript
import React from "react"
const App = () => {
  return (
    <>
      <h1>Netflix Clone</h1>
      <ul>
        <li>show1</li>
        <li>show2</li>
        <li>show3</li>
        <li>show4</li>
      </ul>
    </>
  )
}
export default App
```

But this is a lot of work and:

- not dynamic
- not DRY (Don't Repeat Yourself)

How an we make this cleaner and more efficient?

1.  Store items in state
2.  Create Show component
3.  Pass state as props to Show component

### 1. Store items in state

We saw yesterday we can store an array of items in state. Those items can be objects! We can give them key value pairs of title and liked. We want to set the initial values of the liked keys to 'false', then eventually we will change that to true on a click event. But first we must create state.

```javascript
import React, { useState } from "react"

const App = () => {
  const [showList, setShowList] = useState([
    { title: "", liked: false },
    { title: "", liked: false },
    { title: "", liked: false },
    { title: "", liked: false },
  ])
  return (
    <>
      <h1>Netflix Clone</h1>
      <ul>
        <li>show1</li>
        <li>show2</li>
        <li>show3</li>
        <li>show4</li>
      </ul>
    </>
  )
}
export default App
```

### 2. Add Show Component

- make components folder
- add Show.js to folder

```javascript
import React from "react"

const Show = () => {
  return <h4>Show name</h4>
}
export default Show
```

### 3. Pass data to Show via Props

Then we need to create a nested component that can display each show item. By mapping over the array of objects we can pass each show object to the nested Show component. _Anytime we are mapping UI content in React we will need to include a **key** with a unique identifier._ In this case, we will use the item’s index as this identifier.

```javascript
{
  showList.map((show, index) => {
    return <Show show={show} key={index} />
  })
}
```

## CONDITIONAL RENDERING

Each show object can be accessed as props. Let's show the name of the item.

**TODO: add `{props.show.title}` in place of Show Name in Show component**

We can use something called **conditional rendering** to display a message ONLY when the show has been liked . To do this, we use JavaScript's logical AND as a toggle between when a JSX element is shown and when it is ignored. Then we can add a button that corresponds to each show listed.

```javascript
const Show = (props) => {
  console.log("props: ", props)

  return (
    <>
      <h4>{props.show.title}</h4>
      {props.show.liked && <h4>💙</h4>}
      <button>Like!</button>
    </>
  )
}
```

### Destructuring props

show how to destructure within the function, then as params

## The Problem

We want to click on the button and have our selection marked as ordered. Which means we need to update the state object for that item to `liked: true`. However, state data is managed by App.js BUT the button and click action by necessity are handled by the Show component. This means we need to send info of what is being liked "up the river" to App.js where the state data lives. How do we do this - with Functional Props!

## The Steps:

1. Create a function that will have an argument that can be bassed down to the Show component and will be called when the button is clicked.

_`src/App.js`_
below state add:

```javascript
const likeShow = (selectedShow) => {
  console.log("clicked!")
}
```

2. Then we pass this method in our component call, along with the menuItems. We will want to know which item is ordered and its state updated. For this we will pass the index.

_`src/App.js`_

```javascript
;<h1>Netflix Clone</h1>
{
  showList.map((show, index) => {
    return <Show showData={show} likeShow={likeShow} index={index} />
  })
}
```

3. Now I can add an onClick in the button that will trigger the likesShow function
   _`src/components/MenuItem.js`_

```javascript
  const Show = (props)=> {
    console.log('props: ', props)
    const { show, likeShow } = props

    return(
      <>
       <h4>{props.show.name}</4>
       {props.show.liked && <h4>💙</h4>}
       <button onClick={props.likeShow}>Like!</button>
      </>
    )
  }
```

If we look back at App.js we can see `likeShow` takes an argument. So what can we use to specify which item was selected? The index.

_`src/components/MenuItem.js`_
**rewrite onClick method**
`<button onClick={props.show(props.index)}>Like!</button>`

However, if we look at the console - we see all these clicks and I haven't done any clicking. This current setup creates an Immediately Invoked Function -> it won't wait for the actual click and will continue to invoke itself. This can lead to a Stack overflow - ( program tries to execute more actions than it has the memory to perform.)

But there is a solution - we can add an anonymous fxn INSIDE the onClick.
_`src/components/MenuItem.js`_
**rewrite onClick method**
`<button onClick={()=> {props.likeShow(props.index)}}>Like!</button>`

4.  Now back in App.js we can actually access the index from the Show component.
    Then we just need to update the value of the liked property and call setShowList. We can use the spread operator to show the updated state. The spread operator says copy all or part of an existing array or object into another array or object.

_`src/App.js`_

```javascript
import React, { useState } from "react";
import "./App.css"
import Show from "./components/Show";

const App = () => {

   const [showList, setShowList] = useState([
    {
      title: "The Last of Us",
      liked: false,
    },
    {
      title: "Succession",
      liked: false,
    },
    {
      title: "Steven Universe",
      liked: false,
    },
    {
      title: "Ozark",
      liked: false,
    },
    {
      title: "Killing Eve",
      liked: false,
    },
    { title: "Ted Lasso", liked: false },
    { title: "A Different World", liked: false },
    {
      title: "Buffy, the Vampire Slayer",
      liked: false,
    },
  ])
  return(
  const likeShow = (selectedShow) => {
    console.log("show: ", showList[selectedShow])
    showList[selectedShow].liked = true
    // Notice nothing happens...why?
    setShowList([...showList])
 }

 return (
   <>
      <h1>Netflix Clone</h1>
      <div className="wrapper">
        <div className="cards">
          {showList.map((show, index) => {
            return (
              <Show show={show}
                key={index}
                likes={likeShow}
                index={index}
              />
            )
          })}
        </div>
      </div>
    </>
 )
```

## To add output of your order:

```javascript
;<h4>Favorites: </h4>
{
  showList
    .filter((show) => show.liked === true)
    .map((s) => {
      return <h3>{s.title}</h3>
    })
}
```

## To hide the button when show is liked

**Show.js**

```javascript
<button
  onClick={() => {
    likes(index)
  }}
  className={`button-${index}`}
>
  Like!
</button>
```
