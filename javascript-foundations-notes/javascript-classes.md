# Javascript Classes Lecture Notes

How many people here bake?  What do you need to make a recipe? Ingredients! How many servings does it make? Depends the amount of ingredients you have.  What's the difference between a recipe and a serving? Recipe is a set of instructions that makes the baked good.  If you had an endless supply of ingredients and time, you could make an infinite amount of cookies.

In Javascript, classes are recipes for making objects.  They will have data (what we need aka ingredients) and action (what to do with the things we need)

Let's use a simple example from outside of the kitchen to show how this works: a car

There are many types of cars out there, but they are all made up of similar components or properties (or ingredients). Can we all agree that all cars have a make, a model, a year, and a color?

Let's look at building a car class

There is a specific structure and syntax for declaring classes.  JS reserves a specific keyword to declare a class ==> class

class declaration: use PascalCase for classname (first letter is capitalized, and all subsequent words are capitalized.) This is very important. recipeBook and RecipeBook represent two very different things.  Variable name, class.

class + NameOfClass + curly brackets
```javascript
class Car {
}
```

Now we need an action to build the object.  This is the constructor method. Notice it ends with parenetheses.  All methods have () for invocation

The constructor method will be the first method declared in your class

```javascript
class Car {
  constructor() {

  }
}
```
Inside or constructor we can save special variables that refer to the object we'll be making. What keyword do we use to refer to the object it belongs to? 
This!  This works on keys.
```javascript
class Car {
  constructor() {
    this.make = "Subaru"
    this.model = "CrossTrek"
    this.year = "2016"
    this.color = "Blue"
  }
}
```

When we call on our class to make a new object, we call this instantiation - creating an instance of a class. And was is an instance of a class...object.

To make this new object we use another reserved keyword ==> new

We assign a variable to the keyword new and the name of the class that was already declared.  In this case, the Car class.

```javascript
let myCar = new Car()
console.log(myCar)
```
output--> Car { make: 'Subaru', model: 'CrossTrek', year: '2016', color: 'Blue' }

What's the problem here though? It's not dynamic! So how do we make something dynamic? Think of a function - how do we make a function dynamic rather than hardcoding the values?  Parameters.  The constructor will take in parameters that will be the values of the key-value pairs
```javascript
class Car {
   constructor(makeString, modelString, yearNumber, colorString) {
       this.make = makeString,
       this.model = modelString,
       this.year = yearNumber,
       this.color = colorString
   }
   
}
```
let myDreamCar = new Car("Porsche", "Boxter", 2023, "Silver")
console.log(myDreamCar)

remember the ORDER the arguments are passed is IMPORTANT.  The class will relate it to the object value, but doesn't know the order.

*** Switch things around ***

Classes can also create custom methods
A Method is a function that operates on the class it belongs to. To create a method we declare a key with parentheses and curly braces outside of the contructor, but inside the scope of the class.

```javascript
class Car {
   constructor(makeString, modelString, yearNumber, colorString, electricBoolean, false)  {
       this.make = makeString
       this.model = modelString
       this.year = yearNumber
       this.color = colorString
       this.isElectric = electricBoolean
       this.isOperational = true
   }
  carBoasting() {
       return `My ${this.make} ${this.model} is super cool`
   }
   brokeDown() {
       this.isOperational = false
   }
}
let myDreamCar = new Car("Porche", "Boxter", "2022", "Silver", false)
console.log(myDreamCar)
myDreamCar.brokeDown()
console.log(myDreamCar)
```

There is so much you can do with these methods. You can put any logic in between those curly braces.  Anything you've already learned like conditionals, HOF, can go in there. 
Methods are a way to act with the objects key-value pairs.

REVIEW:
1. What keyword do we use to declare a class?
2. What naming convention do we use for class names?
3. What is the name of the method we call in the class that will build an object.
4. What keyword do we use to create a new instance of the class



