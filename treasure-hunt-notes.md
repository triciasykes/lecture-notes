# React Treasure Hunt Mob Programming Notes

Today we are going to recreate the Treasure Hunt game you all made in Jumpstart in React. We will do this together- mob programming -so you should be coding along.  We are going to take this one User Story at a time - that means one TASK at a time.

## Setup
- Github classroom project link:  https://classroom.github.com/a/7sLvMT5D

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
The README is a great place to take notes/pseudocode.  Let's also include our branch names to keep everything consistent.

## User Story 1
 `As a user, I can see a page with a three by three grid board game with a question mark in each square.`
 **add** 
  - branch: game-board

  We have a square component provided in the components folder, so let's call it in App.js

  ```javascript
   src/App.js

   import Square from './components/Square'

   return (
    <>
      <h1>Treasure Hunt Game</h1>
      <Square />
    </>
  )
```
Let's confirm there's a square.  Now we actually need 9 squares.  We may be tempted to just repeat the component call. But we want to pass information into each square dynamically and this doesn't not follow the rule of DON'T REPEAT YOURSELF (DRY).  

We have this array of values in state saved in the variable board.  Let's map over this state variable and return a component call for each value.

```javascript
  {board.map((square) => {
    return (
      <Square />
    )
  })}
```

Great! Now we have 9 squares, but not how we want them to appear.  And if we look at the elements in th console, we see these are 9 independent blocks.  A <b>div</b> is a block level element which means it will take up the entire width of the screen.  We want to modify all squares as one entity, so we can wrap in another div and give that div className of 'board'.


```javascript
<div className="board">
  {board.map((square) => {
    return (
      <Square />
    )
  })}
<div>
```

***`src/App.css`***

```css
.board {
  display:flex;
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

***src/App.js***

`<Square square={square} />`

Now we can reference square in our Square.js


***src/Square.js***
```javascript
const Square = ({square}) => {
  return (
    <>
      <div className="square">{square}</div>
    </>
  )
}
```
This is a neat trick - we can actually pass {square} with the curly braces which is the same as props.square. It's a way of object destructuring - pulling out the value and saves us from having to write props. blah blah blah.

Finally - let's style the question marks.

***src/App.css***
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
