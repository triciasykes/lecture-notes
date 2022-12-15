# Functional Props Lecture Notes

We discussed React Props yeterday and we learned that we can send props downstream from Parent component to Child component. But what do we do when we need to send data from Child to Parent?
This is where **functional props** come in.

In my terminal I'm in the hotel-lecture-notes repo on the main branch.
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
I've decided we are going to have a holiday party. It's virtual though - so let's make a menu that allows you to click to order an item. We are going to do this one step at a time. I'm going to need your help here because I'm not a great at planning food for others. 

*src/App.js*
```javascript
  import React from 'react'
  const App = () => {
    return(
      <>
        <h1>Hotel Holiday Happening</h1>
        <h3>Menu</h3>
          <ul>
            <li>item1</li>
            <li>item2</li>
            <li>item3</li>
            <li>item4</li>
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
 
 1. Store items in state
 2. Create menu component
 3. Pass state as props to menu component

 ### 1. Store items in state
 ```javascript
 import React, { useState } from 'react'

 const App = () => {

  const [menu, setMenu] = useState([
    { name: "Mac & Cheese", ordered: false}
    { name: "Baked Potato", ordered: false}
    { name: "2 Tamales", ordered: false}
    { name: "Roast Beef", ordered: false}
  ])
  return(
    <>
       <h1>Hotel Holiday Happening</h1>
        <h3>Menu</h3>
    </>
  )
 }
 export default App
 ```
### 2. Add Menu Component
```javascript
 const MenuItem = () => {
  return(
    <>
      <h4>Food Item</h4>
    </>
  )
 }
 export default MenuItem
 ```

 ### 3. Pass data to MenuItem via Props
 Then we need to create a nested component that can display each menu item. By mapping over the array of objects we can pass each menu object to the nested menuItem component. *Anytime we are mapping UI content in React we will need to include a **key** with a unique identifier.*  In this case, we will use the item’s index as this identifier.
 ```javascript
  {menu.map((item, index) => {
           return (
             <MenuItem
               item={item}
               key={index}
             />
           );
         })}
```

## CONDITIONAL RENDERING

Each menu item object can be accessed as props. Let's show the name of the item. 

 **TODO: add `{props.item.name}` in place of Food Item Name in MenuItem component**
 
 We can use something called **conditional rendering** to display a message ONLY when the item has been ordered. To do this, we use JavaScript's logical AND as a toggle between when a JSX element is shown and when it is ignored.  Then we can add a button that corresponds to each menu item.

```javascript
  const MenuItem = (props)=> {
    console.log('props: ', props)

    return(
      <>
       <h4>{props.item.name}</4>
       {props.item.ordered && <h4>Ordered</h4>}
       <button>Order</button>
      </>
    )
  }
```

## The Problem

We want to click on the button and have our selection marked as ordered. Which means we need to update the state object for that item to `ordered: true`.  However, state data is managed by App.js BUT the button and click action by necessity are handled by the MenuItem component.  This means we need to send info of what is being ordered "up the river" to App.js where the state data lives.  How do we do this - with Functional Props!

## The Steps:

  1. Create a function that will have an argument that can be bassed down to the MenuItem component and will be called when the button is clicked.

  *`src/App.js`*
  below state add:
  ```javascript
    const orderMenuItem = (selectedItem) => {
      console.log("clicked!")
    }
  ```
  2. Then we pass this method in our component call, along with the menuItems. We will want to know which item is ordered and its state updated.  For this we will pass the index.  

  *`src/App.js`*
```javascript

  <h1>Hotel Holiday Happening</h1>
  <h2>Menu</h2>
  {menu.map((item, index)=> {
    return(
      <MenuItem
        item={item}
        orderMenuItem={orderMenuItem}
        index={index}
      />
    )
  })}
```

3. Now I can add an onClick in the button that will trigger the orderMenuItem function
*`src/components/MenuItem.js`*
```javascript
  const MenuItem = (props)=> {
    console.log('props: ', props)

    return(
      <>
       <h4>{props.item.name}</4>
       {props.item.ordered && <h4>Ordered</h4>}
       <button onClick={props.orderMenuItem}>Order</button>
      </>
    )
  }
```
  If we look back at App.js we can see `orderMenuItem` takes an argument. So what can we use to specify which item was selected?  The index.

*`src/components/MenuItem.js`*
**rewrite onClick method**
`<button onClick={props.orderMenuItem(props.index)}>Order</button>`

However, if we look at the console - we see all these clicks and I haven't done any clicking. This current setup creates an Immediate Invoked Function -> it won't wait for the actual click and will continue to invoke itself. This can lead to a Stack overflow - ( program tries to execute more actions than it has the memory to perform.)

But there is a solution - we can add an anonymous fxn INSIDE the onClick.
*`src/components/MenuItem.js`*
**rewrite onClick method**
`<button onClick={()=> {props.orderMenuItem(props.index)}}>Order</button>`

4.  Now back in App.js we can actually access the index from the MenuItem component.
 Then we  just need to update the value of the ordered property and call setMenu. We can use the spread operator to show the updated state.  The spread operator says copy all or part of an existing array or object into another array or object.
 
*`src/App.js`*
```javascript
import React, { useState } from "react";
import "./App.css"
import MenuItem from "./components/MenuItem";

const App = () => {

  const [menu, setMenu] = useState([
    { name: "Mac & Cheese", ordered: false}
    { name: "Baked Potato", ordered: false}
    { name: "2 Tamales", ordered: false}
    { name: "Roast Beef", ordered: false}
  ])
  return(
     const orderMenuItem = (selectedItem) => {
   console.log("item: ", menu[selectedItem]);
   menu[selectedItem].ordered = true;
   // Notice nothing happens...why?
   setMenu([...menu]);
 };
 
 return (
   <>
     <div className="main-container">
       <div className="menu-div">
         <h1>Hotel Holiday Happening</h1>
        <h3>Menu</h3>
         {menu.map((item, index) => {
           return (
             <MenuItem
               item={item}
               key={index}
               orderItem={orderMenuItem}
               index={index}
             />
           );
         })}
       </div>
     </div>
   </>
 )
 ```

  
       
## To add output of your order:

```javascript  
 <h4>Your order: </h4>
      {menu.filter(item => item.ordered === true).map(i =>{
        return(
          <h3>{i.name}</h3>
        )
      })
    }
```

