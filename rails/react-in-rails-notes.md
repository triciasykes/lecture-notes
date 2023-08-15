# REACT IN RAILS LECTURE NOTES

There are many ways to make a fullstack application. Every company puts technologies together in a way that fits what they are trying to accomplish, so it's a good to see how to use all the tools you already have to create a fullstack app in a different way. 

 With Cat Tinder we created a decoupled app with React on the frontend and Rails on the backend.  Today we will look at how a rails app can serve up React Components. Adding React components inside a Rails project simplifies the flow of information from the database to the view. This is what is called a **MONOLITHIC** application => one app handles both data and views

We will have 2 different routing systems: Rails router for API endpoins and React Router for displaying different pages. 

Why do this?
1. Replace html.erb view with React, which is more powerful.
2. It makes fetch requests easier - they are not cross-origin, they come from the same app.
3. We can add authentication and authorization to create users and allow them to log in.  This is much, much easier in a single app than in a decoupled app!

Let's look at the syllabus for the steps we take to get everything configured.  First we'll create a rails app like we have been.  Cd into it and create database. We'll then run a series of commands that will allow react to run inside of rails

## Setup
- $ rails new hotel-homies -d postgresql -T
- $ cd hotel-homies
- $ rails db:create
- $ rails s

Rails 7 opens up options to developers to choose how to support Javascript - it just requires a bit more setup.  Webpack is the default JS compiler, Webpacker allows us to manage webpack through Rails.

## Setup Continued - add Webpacker and dependencies
- $ bundel add webpacker
- $ bundle add react-rails 
--- bring in files to create webpack:
- $ rails webpacker:install  
- $ rails webpacker:install:react  -- supports react components
- $ yarn add @babel/preset-react  -- adds Babel, which is a translator
- $ yarn add @rails/activestorage  -- came with Rails 6. Allows handling and storage of media
- $ yarn add @rails/ujs  -- clinking links always results in a GET request  but in RESTful apps, you need somelinks to be non-GET requests. UJS allows those clicks to perform non-GET requests and also to add confirmation dialogs before executing an action

- $ rails generate react:install  -- modifies the typical rails structure by creating additional files/folders

Once these are all loaded, we can create React components!  To test it we'll create the App.js component

- $ rails generate react:component App

*** Open VSCODE ***

Let's look at our file structure:
we now have a javascript directory with a components folder inside.  This tells Rails, Hey - I'll be doing React here.  Insdie this components folder we will create our normal React folders of assets, components, pages.  This can get confusing (components inside components) so be sure you are in the correct components folder when adding actual components.

Here we see our App.js


```javascript
import React from "react"

const App = () => {
  return (
    <>
      <h1>Hello Homies!</h1>
    </>
  )
}

export default App
```
Ok, now we want the ability to route React components to show up in Rails view.

- $ rails g controller Home
- $ rm app/helpers/home_helper.rb


**OPEN VIEWS/HOME**

- Add files =>  index.html.erb
  
  Now we can call React component using erb tags:

  <%= react_component 'App' %>

- We need to tell our Rails app to let webpacker handle Javascript compiling
**app/views/layouts/application.html.erb**
- Find this line:
  ` <%= javascript_importmap_tags %>`

  Replace with:
  `<%= javascript_pack_tag 'application', 'data-turbolinks-track': 'reload' %>`

  - Now Add ROUTE:
```ruby
  Rails.application.routes.draw do
    root 'home#index'
  end
```
 What this does:  root is our base url or localhost:3000.  Adding this line tells the app, if nothing else exists in our routes file, render Home controller and call the index method.  Rails magic takes us to the index.html.erb.  

You can review this in the Routes Views Controllers part of Syllabus in the Rails Unit

It is always a good idea to stop your server and restart when you add code to backend. You may get an error that seems to make no sense if you don't.

Now view will render.  Rails s

_____  

OK now on to the CSS
We want to add Reactstrap so we can use the pre-built components.  We need to do a little setup to make REact styles compatible with Rails. Instead of a regular CSS file we will use the SCSS extenstion. SCSS stands for Sassy CSS (combo of SASS and css). It is a superset of css and gives us greater functionality by incorporating imports, functions and more.

Because we need bootstrap to run reactstrap let's start there.
- $ bundle add bootstrap  
Notice we are using bundle instead of yarn - it is a gem 
Then we need to rename the application.css file to .scss. You can running the command or just rename the file in the file tree
- $ mv app/assets/stylesheets/application.css app/assets/stylesheets/application.scss

- $ yarn add reactstrap   -- this one is YARN

application.scss file lives i the Rails app's asset pipeline.  The asset pipeline is where all styles get packaged up and served to the user.  This file is the global stylesheet for the application.
In app/assets/stylesheets/application.scss add:
`@import 'bootstrap'`

-----
Now we have almost all our dependencies... Let's add pages and components.  As usual, we will follow our React structure of creating 3 folders in this app.  Javascript/components

components
- Navigation.js 

pages
- AboutUs.js
- Home.js

```javascript

import React from "react"

const Home = () => {
  return (
    <>
      <h3>This is the Home Page</h3>
    </>
  )
}

export default Home
```


So we set up the route for the backend, but we need  the react router to display the different pages.

- $ yarn add react-router-dom

Now let's import what we need into App.js


component calls in App.js
```javascript
import {
  BrowserRouter, Routes,
  Route
} from 'react-router-dom'
import Navigation from './components/Navigation'
import AboutUs from './pages/AboutUs'
import Home from './pages/Home'


return (
  <BrowserRouter>
    <Navigation />
    <Routes>
      <Route path="/" element={<Home />} />
      <Route path="/about" element={<AboutUs />} />
    </Routes>
  </BrowserRouter>
)
```
So now we have 2 routers. They can conflict.  We need to distinguish where data (JSON) is handled and where HTML is being handled.
We can do this with a Rails feature that allows us to put constraints on requests and funnel all the HTML requests to React, and everything else will be handled by Rails.

Add this to our routes.rb
```ruby
  get '*path', to: 'home#index', constraints: ->(request){ request.format.html? }
  ```


Now we can create our navigation.  Go To Navigation.js

Just remember =>  Both Reactstrap and React Router libraries have a NavLink component.  We will import NavLnk from react router and then hijack the Navlink styles by manually adding it as a class.

app/javascript/components/components/Navigation.js

```javascript
import React, { Component } from 'react'
import { Nav, NavItem } from 'reactstrap'
import { NavLink } from 'react-router-dom'

class Navigation extends Component {
  render() {
    return(
      <>
        <Nav>
          <NavItem>
            <NavLink to="/" className="nav-link">Home</NavLink>
          </NavItem>
          <NavItem>
            <NavLink to="/about" className="nav-link">About Us</NavLink>
          </NavItem>
        </Nav>
      </>
    )
  }
}
export default Navigation
```










