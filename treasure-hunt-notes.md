# React Treasure Hunt Mob Programming Notes

Today we are going to recreate the Treasure Hunt game you all made in Jumpstart in React. We will do this together- mob programming -so you should be coding along. We are going to take this one User Story at a time - that means one TASK at a time.

## Setup

- Github classroom project link: https://classroom.github.com/a/7sLvMT5D

- clone repo
- cd into repo
- $ code .

Similarly to the lightbulb challenge, we need to complete an app that has been created. We are not building from scratch. It is very important to review the code provided before you get started. Make sure all the necessary files exist. Look at the README and make sure you understand what is being asked.  
 **Review file structure s**

We are missing a folder - node modules. Remember that wen cloning for the first time, you must run yarn to add necessary dependencies.

- $ yarn
- $ yarn start

**Go through App.js & Components/Square**
**Look at browser => only rendering h1**

Ok, so we have a good understanding of the basic structure, the current status, and the end goal. Let's start on the User Stories.
The README is a great place to take notes/pseudocode. Let's also include our branch names to keep everything consistent.

## User Story 1

`As a user, I can see a page with a three by three grid board game with a question mark in each square.`
**add**

- branch: game-board

We have a square component provided in the components folder, so let's call it in App.js

```javascript
src / App.js

import Square from "./components/Square"

return (
  <>
    <h1>Treasure Hunt Game</h1>
    <Square />
  </>
)
```

Let's confirm there's a square. Now we actually need 9 squares. We may be tempted to just repeat the component call. But we want to pass information into each square dynamically and this doesn't not follow the rule of DON'T REPEAT YOURSELF (DRY).

We have this array of values in state saved in the variable board. Let's map over this state variable and return a component call for each value.

```javascript
{
  board.map((square) => {
    return <Square />
  })
}
```

Great! Now we have 9 squares, but not how we want them to appear. And if we look at the elements in th console, we see these are 9 independent blocks. A <b>div</b> is a block level element which means it will take up the entire width of the screen. We want to modify all squares as one entity, so we can wrap in another div and give that div className of 'board'.

```javascript
<div className="board">
  {board.map((square) => {
    return (
      <Square />
    )
  })}
<div>
```

**_`src/App.css`_**

```css
.board {
  display: flex;
  flex-wrap: wrap;
}
```

boxes don't stay 3x3 if expand screen.We can fix the format by adding width to the board div.
Looking at the properties of the square class, we can see each square is 200px, PLUS the border of 1px.
so to be safe we'll round up to 610px and add that to the board class.

`width:610px`

There are many ways to center divs on a page. For our purposes we are going to just stick with setting the properties for margin (T/B = 0, L/R - equal on each side)

`margin: 0, auto`

OK! We have a good looking gameboard here. Now we need to display the question marks.

**_src/App.js_**

`<Square square={square} />`

Now we can reference square in our Square.js

**_src/Square.js_**

```javascript
const Square = ({ square }) => {
  return (
    <>
      <div className="square">{square}</div>
    </>
  )
}
```

This is a neat trick - we can actually pass {square} with the curly braces which is the same as props.square. It's a way of object destructuring - pulling out the value and saves us from having to write props. blah blah blah.

Finally - let's style the question marks.

**_src/App.css_**

```css
.square {
  font-size: 10rem;
  text-align: center;
}
```

** note: REM is relative to the root (HTML) font size, so if you wish to scale the elements size based on the root size, no matter what the parent size is, use REM. **

## Wrap up Story 1

1. Add notes to README

- mapped over array in state to dynamically render 9 squares
- passed value of array in state to square
  -styled square

2. add commit push

3. checkout main, pull, delete branch.

## User Story #2

`As a user, when I click on one of the question marks an alert appears with the index position of that question mark in the array.
`

- branch: index-position
- $ git checkout -b index-position

We know we need to add an onClick to Square div.
**Go to Square.js**

`<div className="square" onClick={handleClick}>{square}</div>`

Now define this method in SQUARE.js

```javascript
const handleClick = () => {
alert("aloha")
}

```
While this works, each square doesn't know where it is in respect to the board. So let's pass index in our map function and then pass it in the component call. This way we can pass it downstream to Square.js.

***src/App.js***
```javascript
 {board.map((square, index) => {
    return (
      <Square
        square={square}
        index={index}
      />
    )
  })}
```

***src/components/Square.js***
```javascript
const Square = ({square, index}) => {

  const handleClick = () => {
   alert(index)
  }
  return (
    <>
      <div className="square" onClick={handleClick}>{square} </div>
    </>
  )
}
```
Ok - We are closer! But when I click on square I'm going to want to modify the array and need the logic in App. 
Need alert to come from App not Square. It needs to be available in App.

We have been setting this up, but App.js still doesn't know where the square is. Let's build out the basic structure for our game play logic.
We will need to use Functional Props.

***App.js***

```javascript
 const handleGamePlay = (clickedSquare) => {
  alert(clickedSquare)
 }

 <Square 
    handleGamePlay={handleGamePlay} 
    square={square}
    index={index}
    key={index} 
    />
```

Notice the key error - any time we iterating over a display element, React requires a unique identifier to tell react which element needs updating. This helps React function better - doesn't change anything visually.

***Square.js***
Now in Square js we can add handleGamePlay to the params and then replace alert with the method.
```javascript
const Square = ({square, index, handleGamePlay}) => {

  const handleClick = () => {
    handleGamePlay(index)
  }
  ```
## User Story #2 Complete!
- Return to README
- added onClick to square div
- added handleClick method to square.js
- passed index to square & handleClick
- add handleGamePlay to App.js
- passed handleGamePlay to square to get index thru functional props

git add, commit, push
git checkout main, git pull, git branch -d index-position
## User Story #3
`As a user, when I click on one of the question marks instead of the alert the question mark turns into a tree emoji.`

- branch: tree-emoji

- git checkout -b tree-emoji

At this point, Square is done. We can focus on the logic in App.js. Square will display whatever we pass it.

We know that clickedSquare holds the index. We want to update the array in state given an index. Remember, React doesn't want us to manipulate state directly. React wants to be in charge. So how do we set this up.

We can make a copy of the array, manipulate it, and then let React set the state.
Let's start by making a variable that holds the copy of the state value.  For this we can use the spread operator.

```javascript
  const handleGamePlay = (clickedSquare) => {
    let updateBoard = [...board]
  }
```
Then since we know the index, we can access the square and reassign the value to the tree-emoji, and then use setBoard method to set this updated array in state.
```javascript
  const handleGamePlay = (clickedSquare) => {
    let updateBoard = [...board]
    updateBoard[index] = "🌲"
    setBoard(updateBoard)
  }
```
## User Story #3 Complete!
in README
- branch: tree-emoji
- made copy of the board using spread operator
- updated the value of square at particular index to be tree emoji
- emoji keyboard accessed by CTRL + CMD + Spacebar


## User Story #4
`As a user, if I select the winning square the question mark will become a treasure emoji and if I select the losing square the question mark will become a bomb emoji.`
branch: treasure-bomb

- $ git checkout -b treasure-bomb

We need a random treasure location and a random bomb location. We can make state variables for these. Let's start with the treasure part.

```javascript
  const [treasureLocation, setTreasureLocation] = useState(Math.floor(Math.random() * board.length))
```
Add a console.log for treasureLocation to make sure it's working. 

We know we need a conditional - if the treasure location is clicked then show a treasure ELSE show a tree.
```javascript
 const handleGamePlay = (clickedSquare) => {
    // make copy of current state value using spread operator
    const updateBoard = [...board]
    // set condition for if treasure location is same as clicked index
    if (clickedSquare === treasureLocation) {
      // then reassign state value to treasure emoji
      updateBoard[clickedSquare] = "💎"
      // update state with updated board
      setBoard(updateBoard)
    } else {
      // access value at clicked index and set value to tree emoji
      updateBoard[clickedSquare] = "🌲"
      // pass updateBoard to setBoard method to update state
      setBoard(updateBoard)
    }
 }
 ```

 Now we can do the same for the bombLocation
 ```javascript
 const handleGamePlay = (clickedSquare) => {
    // make copy of current state value using spread operator
    const updateBoard = [...board]
    // set condition for if treasure location is same as clicked index
    if (clickedSquare === treasureLocation) {
      // then reassign state value to treasure emoji
      updateBoard[clickedSquare] = "💎"
      // update state with updated board
      setBoard(updateBoard)
      // set condition for if bomb location is same as clicked index
    } else if (clickedSquare === bombLocation) {
      // reassign state value to bomb emoji
      updateBoard[clickedSquare] = "💣"
      // update state with updated board
      setBoard(updateBoard)
    } else {
      // access value at clicked index and set value to tree emoji
      updateBoard[clickedSquare] = "🌲"
      // pass updateBoard to setBoard method to update state
      setBoard(updateBoard)
    }
  }
  ```
Now we have a working game!

## User Story 4 Complete!
in README:
- branch: treasure-bomb
- added random location for bomb and treasure into state
- added a conditional in the handleGamePlay method to produce different outcomes

## User Story 5 Complete!
`As a user, I can click on a “Play Again” button that will restart the game`

Now we want to be able to clear the board and start a new game when we click a button.  So first things first. Let's add a button to our App.js

- branch: game-reset

```javascript
  <div>
    <button className="reset-button" onClick={handleReset}>
      Play Again!
    </button>
  </div>
```

We know that the button will have an onClick event, so let's set it to call a handleReset method. Now let's define the method. 
```javascript
  const handleReset = () => {

  }
```
What needs to happen in this method:  
1. board needs to hold all the initial values of question marks.
2. treasureLocation needs to be set
3. bomb Locatin needs to be set

the set methods allow us to pass in whatever value we want so we can simply pass an array of question marks to setBoard.
We can then also pass the random logic to both the setTreasureLocation and setBombLocation methods.

```javascript
const handleReset = () => {
    setBoard(["?", "?", "?", "?", "?", "?", "?", "?", "?"])
    setTreasureLocation(Math.floor(Math.random() * board.length))
    setBombLocation(Math.floor(Math.random() * board.length))
  }
```
Finally, let's style the button a bit.
We should add a className to the div if we want to center the button.  Here we can just use text-align.
```css
.button-section {
  text-align: center;
}
.reset-button {
  background-color: royalblue;
  margin-top: 20px;
  padding: 10px;
  border-radius: 10%;
  font-size: 1.5rem;
}
```
## User story #5 complete!
in README:
- branch: game-reset
- added a button at the bottom of the page
- added handleReset onClick
- handleReset sets the original state for board, sets a new random number for treasure and bomb

# THE END