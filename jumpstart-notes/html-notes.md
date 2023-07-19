
Hi! My name is Tricia, I'm another Instructor at lEARN. OK - You've seen how to set up an html file - now, let's build a webpage! We'll talk about some additional html tags and external sources you can use to help with your structure. 
 
 Alright, let's get to it!
 let's start by planning out what we want our page to look like. We need different pieces of the page...

Looking at this site we can see some fundamental elements that we can use in our own page. Above the title, we see this horizontal line. We can add a line using the <hr> tag, which stands for horizontal rule.  I don't think we need 6 titles, so let's remove some and add our line under it. While we are here, let's change the page title from Document to Apple Pie! Now we need some content.  We will start by setting up the area for paragraphs. We'll start with the div tag.

A div creates a division in our body. It works well as a container for other html elements.  We are going to use our div tag to contain our paragraphs, or <p> tag. Since we are nesting one element within another, we will indent our p tags. This helps readability.
Alright, now all we need is text.  
    Lorem Ipsum is a kind of fake latin that developers use to hold as a placeholder until something more permanent can be created. It was created in the 1500s as a way to test printing presses. Many developers have had great fun creating different themed Ipsum text. Hipster Ipsum, Pirate Ipsum, Zombie Ipsum, Cat Ipsum. 
    We are going to stick the origin ipsum and use it to make a couple of paragraphs. I am on loremipsum.io. I can hit this copy button and paste it between the p tags.  I think this is a lot of text so let's break into 2 paragraphs. 

So we have some text that will eventually talk about our fabulous pie. Now we need ingredients and directions.  
  a ul tag creates an UNORDERED list which is perfect for setting out a list of ingredients. 

  Then we can add our <ul> tag.  The ul tag will wrap around all the list items, which we can now add using the <li> tag. Don't forget to add the closing tags! Then let's add a heading for this section
  <h3>Ingredients<h3>
<ul>
      <li> Apples</li>
      <li> Pie crusts </li>
      <li> White sugar </li>
      <li> Brown sugar </li>
      <li> Cinnamon </li>
      <li> Nutmeg </li>
<ul>
 I think I'd like a bit more space between the paragraphs and the ingredients.  I can force a line break by using the <br> tag. 

 
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


