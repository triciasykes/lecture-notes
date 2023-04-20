# Restful Routes

Sarah spent some time talking about how the internet works from a full stack developer perspective. The idea of this request response cycle and that the request was a location and an action and the response was a status code and a payload.  then we saw the location is the URL and yesterday you all did routes, views and controllers, and params. You had to go into your routes to specify what was going to match in the URL in order to trigger a
particular route. Then also in your routes you had to define an HTTP verb -  you had to say okay we're going to this place and  it's going to be a get request meaning it's going to display information. 
As a full stack developer you're going in and you define your location, you define your action, you make that request, your status code is going to come back as a success or an error and then the payload that you request gets loaded.

Today we need to talk about restful routes. RESTful Routes (Representational State Transfer) are what map CRUD actions and the corresponding HTTP verb into how we construct the controller for a full stack application.  Restful routes are just a conventional pattern to follow when structuring different routes for interacting with the server whenever an HTTP request is made by the client.  Rails has a very very restful route architecture so it follows this pattern exactly. Again naming conventions are incredibly important! 

To talk about restful routes let's first talk about CRUD - what does CRUD stand for?
create read update delete
and what is CRUD?
 it's a developer methodology. we are making sure that these actions exist in our code. I'm using CRUD as a philosophy to say 
Can my user see the information that I need them to see? can my user create the information I need them to create?, etc. Then that maps over to our HTTP verbs which IS  something that we code into the application. What are our five HTTP verbs
get post put patch delete 
Let’s map these:
if I'm doing a create CRUD action what is the HTTP verb  - POST
Like  if you're posting something online right you're creating content that doesn't currently exist
 if you're reading content what is the  HTTP verb - GET
get requests are going to return HTML right we talked about different ways that we can have our payload. A get request is going to get you markup
How about if I am making an update CRUD action - PUT and PATCH
Delete? DELETE

okay so this makes sense in kind of a developer philosophy standpoint but what
happens when we actually need to go create a full stack application?  At that point we need controller actions because the controller actions decide everything that goes on in our app. Think about the idea of MVC architecture. We spent a couple of days working with just the model layer - you worked with active record, worked in the rails console where you made requests for data and returning specific types of data or creating new types of data, making sure data was valid going into the database, etc. We spent a couple of weeks at the beginning of the cohort working on the View . Then you revisited the view by looking at how you create certain pages based on a request in the URL and the controller is the thing that decides what we're doing with all of that. The controller can make an active record request. It can also display a certain page - so the controller is going to decide how all these things work together.

So with our restful routes there are specific controller actions that are going to get us this basic CRUD functionality and they are: 

index show new create edit update and destroy

Today we're going to work through creating these controller actions that are going to perform these particular restful routes .

If we see an INDEX controller action for index we are getting a list of all the things so this is going to interact with our database and then show our user all of the things that are in that current database table.

**on table**
index - getting a list of all the things from the database
show -  details of just one thing

if I was making an active record request for the first item in the database I get back one instance from the database that would be equivalent to a show action
you can think of it from a user perspective if you're seeing a list of things and you click on
one thing to see more details about that particular thing.  That's a very common workflow that we're used to from a ux perspective

new - skip for now
create - adding new content to the database
edit - skip for now
update - updating existing data
Destroy - removing data

You've done all of these five things that we've talked about so far in active record in the rails console right. Those are actions that we're doing on the data side that then we're going to present to the user to be able to do from a View perspective. The controller is going to help us get between those two things.

# New and Edit
Let's go back to NEW and EDIT because these are things that we haven't had to use yet in terms of doing a performing CRUD actions.
New exists because there is a point where we need our user to provide content that then can be posted to the database . CREATE is a post action. Does post adisplay of view to the user? No.  POST takes data and puts it into the database but we need to present a View to our user that's going to allow them to put data into the database. We need a form that a user can fill out.  Then we take that data from the inputs and that data gets created in the database

The same thing with update. Update on its own is a put or a patch request so there's nothing for our user to see, but we need to offer our user a place to update information. So edit is also a form. 

Does filling out a form equal new items in the database? No. Because you would have to submit it. You have to be able to fill out a form and then there's a specific action on just about all forms that's going to submit that information. Usually some kind of Click action - some kind of call that says click here and then this becomes a submitted data and so that is the difference between new and create and with edit and update ->
new is not actually creating the data it's just providing our user a place to see it. Create is that submit button. Even though we may think of new and create as closely tied together, new is actually a GET request. Same with EDIT. Why? because it's just providing a visual place where we can see information - user adds info on the form and then at the end there's some kind of call to either create or update which triggers either our post or patch request.

Obviously,delete and Destroy are connected from our HTTP verb to our controller action.

This is the the format that we're going to follow today we're going to work through these controller actions!
We have CRUD which is our big picture developer philosophy that says can our app perform these types of actions for our user. - PHILOSOPHY.

We have the HTTP verbs which make successful requests and response cycles.  We have to specify the action that we're taking - REQUESTS.

Then we have the actual controller methods that we'll code to collect whatever data we need and display whatever appropriate views are to the user depending on the type of action - METHODS.

The end.
