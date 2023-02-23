<!-- Sarah start -->
### **Boilerplate**
<hr>
Now let's put some HTML into a new document and open it in the browser.


**ACTION** - on index.html use 'html' shortcut for boilerplate
This is the underlying structure that every HTML document will always have.  Let's take a look at it.

```html
<!DOCTYPE html> 
<html lang="en" dir="ltr"> 
   ( lang="en" stands for the language is in english
    dir="ltr" stands for direction runs from left to right)

<head> One Head / Metadata and info / Things you don’t see on the screen

   <title>LEARN's Apple Pie</title> Shows up in tab / Helps with SEO / Everything You write goes between HTML tags
</head> 
<body>
  	Everything we can see on the page
</body>
</html>
```

### **Saving Files**
<hr>
- This is a good time for us to stop and talk about saving our files. Up at the top of the VSCode file we can see a dot. This is letting us know that the file is currently not saved. Without saving, we can't view the changes in the browser.  
- As developers, it is very important to save frequently.
- We can save by going through the same process as before by going to File on top of the screen and click on Save from the dropdown menu.
- or we can use the keybinding shortcut of CMD + s for a mac and CTRL + S for windows.


### **Displaying the File in Chrome**
<hr>
In order to display the changes we are going to make we are going to need to connect our file to our chrome browser.

- At the top of Atom we’ll see a small google chrome symbol inside of a white document. If we drag and drop this chrome symbol into chrome our page will display.

- You have to be careful to grab the chrome symbol or else it won’t work.
<hr>
<!-- Sarah end -->

### **Headings**
- There are 6 built in headings: h1 through h6
- h1 is largest and h6 is smallest

**ACTION**  type out "Hello World" copy 5x and show each heading
- Remember in order to get the changes to we've made to display we have to save our file and refresh the screen.

**ACTION:** Finish demo with an h1 that says "Apple Pie"
 - add h2 that says "LEARN's Delicious Apple Pie Recipe"
```html
<h1>Apple Pie</h1>
<h2>LEARN's Apple Pie</h2>
```


 ### **Planning**
 - Let's plan out what we want our page to look like. We need different pieces of the page...

 **ACTION:** look at recipe online or use
https://littlespoonfarm.com/apple-pie-recipe/
- While looking over recipe, explain each of basic parts we want to bring into our site.
```html
- Br, hr <br> & <hr>  --> horizontal rule
- Paragraph <p></p>
- Image <img src="..." alt="...">
```

### **Setting up the Tags**
**ACTION**
```html
<div>
  A div creates a division in our body. It works well as a container for other html elements.  We are going to use our div tag to contain our <p> tag.

  Explain lorem ipsum to the p tag
    Lorem Ipsum is a kind of fake latin that developers use to hold as a placeholder until something more permanent can be created. It was created in the 1500s as a way to test printing presses. Many developers have had great fun creating different themed Ipsum text. Hipster Ipsum, Pirate Ipsum, Zombie Ipsum...I like Cat Ipsum.  So much I have it saved to my favorites.
```

Cat ipsum dolor sit amet, try to hold own back foot to clean it but foot reflexively kicks you in face, go into a rage and bite own foot, hard or cats woo run as fast as i can into another room for no reason, yet thinking longingly about tuna brine. 
```html
  <body>
    <h1> LEARN's Apple Pie </h1>
    <h2> A spoonful or forkful will make your worries go bye! </h2>
    <hr /> -- Creates a line
    <div>
      <p> Go to your kitchen and grab your utensils. Let them know they are about to do something spectacular. Tell your tastebuds to get ready for a splendid occurence because you are about to bake some Learn Apple Pie! </p>

      <p> Cat ipsum dolor sit amet, try to hold own back foot to clean it but foot reflexively kicks you in face, go into a rage and bite own foot, hard or cats woo run as fast as i can into another room for no reason, yet thinking longingly about tuna brine. Decide to want nothing to do with my owner today scream at the bath fat baby cat best buddy little guy steal mom's crouton while she is in the bathroom. </p>
    </div>
  </body>
  ```

  ### **List**
  We need ingredients and directions.  
  - UL - a ul tag creates an UNORDERED list which is perfect for setting out a list of ingredients

```html
<ul>
  <h3>Ingredients<h3>
```
- LI - Then inside this ul tag we can use the li or list item tag to wrap around each item. Make sure you add closing tags!
```html
      <li> Large Granny Smith apples (1/2 inch slices) </li>
      <li> Large Honeycrisp apples (1/2 inch slices) </li>
      <li> Large Golden Delicious apples (1/2 inch slices) </li>
      <li> Pie crusts </li>
      <li> White sugar </li>
      <li> Brown sugar </li>
      <li> Cinnamon </li>
      <li> Nutmeg </li>
      <li> Lemon juice </li>
      <li> Egg </li>
<ul>
  ```
- Then for the cooking process, because you have to do things in a specific order, we will use the OL tag, which stands for ORDERED LIST
- Let's use an h3 again for consistency. Then between the OL tags we'll again wrap our list items with <li> tags.
```html
   <h3>Instructions</h3>
    <ol>
      <li>Preheat oven to 400F</li>
      <li>Mix ingredients together</li>
      <li>Pour into pie crust</li>
      <li>Bake for 30 minutes until golden</li>
    </ol>
```
### **Image**
Now let's find an image we can add to our page.  
google -> images --> tools --> Creative Commons

The `<img>` tag creates a holding space for the referenced image.

The `<img>` tag has two required attributes:

src - Specifies the path to the image
alt - Specifies an alternate text for the image, if the image for some reason cannot be displayed


Let's add this image under our headings.
```html
<img src="https://upload.wikimedia.org/wikipedia/commons/4/4b/Apple_pie.jpg" alt="picture of delicious apple pie">
```

Whoa that is too big. But we can fix that. You can put other attributes such as height inside the tag.

`<img src="..." alt="..." height="300px">`

### **Attributes**
- What is an attribute? --> HTML attributes modify an HTML element.  We saw that the src attribute provide the pathway to an image.  the height attribute allowed us to pass in a value that changed the size of that image. As you'll see throughout the weekend, there are many different attributes you can use in various situations. here's one:

```html
  <p style="color:red">This is a paragraph.</p>
  ```
<hr />

### **Add Footer**
- a footer is a standar section of any web page that generally holds some info regarding the authors of the site, copyright, a link to more info or possibly to outside resource
- to create a footer we simply make a tag with the word 'footer'

`<footer></footer>`

-in this tage I can put the copyright logo , **&copy** (no space between) and add the names in my team
```html
<footer>
  &copy LEARN Instructors and TA's | Jumpstart|
</footer>
```

### **Anchor Tags and Navigation**
- what would make this footer even better would be a link to take me back to the top of the page
- Let's make a navigation link in our footer that will go to the top of the page so people don't have to scroll all the way up
- the anchor tag is how we create those famous blue links in HTML
- the anchor tag is made simply with the letter "a"
```html
<footer>
  &copy LEARN Instructors and TA's | Jumpstart|
  <a></a>
</footer>
```
- the Anchor tag takes an attribute of href and then the place we want the link to go
- href stands for 'hypertext reference'

<footer>
  &copy LEARN Instructors and TA's | Jumpstart|
  <a href="#top">Back to the top</a>
</footer>

- the hashtag before the "top" tells our file to look for an element with an id of "top".  We will need to add id="top" to the first element in our <body> tag if we want it to go to the top of the page.  The id is an attribute we can use to identify a specific tag.

`<h1 id="top">Learn's Apple Pie</a>`
**Show in browser**

- let's also add a link to an external website
- let's set up an a tag to link to the recipe site
```html
<footer>
  &copy LEARN Instructors and TA's | Jumpstart |

  <a href =’#top’>Back to the top</a>
  <a href="https://littlespoonfarm.com/apple-pie-recipe/" target="_blank"> A Similar Apple Pie Recipe </a>
</footer>
```

### **Table**
- This next section is something you will likely need in your treasure hunt game board, but doesn’t quite fit neatly into the recipe page, however, it is important to know.
- We will set up a table which will need multiple nested HTML elements

```html
<table><!-- You will need to start with table tag -->
  <tr><!-- Set up table row -->
    <td>Data goes here</td> <!-- set up table data which there can be as many as needed in a single row.-->
    <td>More data here</td>
    <td>More data here</td>
  </tr>
  <!-- repeat as needed -->
  <tr>
    <td>even more data</td>
    <td>and some more data</td>
    <td>and some more data</td>
  </tr>
  <tr>
    <td>even more data</td>
    <td>and some more data</td>
    <td>and some more data</td>
  </tr>
</table>
```
We want 3 rows each with 3 td's
We can also add some temporary style to our table by using the attribute:
**ACTION: ADD BORDER ATTRIBUTE**
`<table border="1">`

Let's add some data about apples in there:
```html
<table border=1>
  <tr>
    <td> Granny Smith </td>
    <td> Honeycrisp </td>
    <td> Golden Delicious </td>
  </tr>
  <tr>
    <td> Super tart and very firm </td>
    <td> Super crisp, tart, sweet </td>
    <td> Little softer than the others </td>
  </tr>
  <tr>
    <td> Holds up the best </td>
    <td> Holds up great </td>
    <td> Holds up well </td>
  </tr>
</table>
```

### **Favicon**
- a favicon is a small image that sits on the chrome tab
- back in the head tag we need to add a special tag called link

`<link rel="icon" type="image/x-icon" href="some-link-here">`

- As you can see link takes 3 attributes:
  1. rel="icon" --> relation
  2. type="image" --> the type of file you are linking
  3. href= "" --> the href will link to an image address of something
  

  https://publicdomainvectors.org/photos/apple-pie-publicdomain-vector.jpg

### **Button**
- Finally, Let’s make a button on the top of the page to take our user to the recipe if they just want the information.
- First we’ll set up an id at my h3 where the recipe starts and set it to recipe
`<h3 id="recipe">`
- Next we'll create an anchor tag at the top fo the page that will send us to the recipe
- Then inside that <a> tag, we'll create a button tag that will show the words "Go to Recipe"
```html
  <h2>A spoonful or forkful will make your worries go bye!</h2>
  <a href="#recipe">
    <button>Go to Recipe</button>
  </a>
```
<hr />
Ok let's break into our pairs and work through the section on HTML Treasure Hunt Section in the 'Jumpstart Weekend Student Notes'

We'll come back together for chekout at 8:45.
