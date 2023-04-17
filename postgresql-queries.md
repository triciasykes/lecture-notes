# Postgresql and Databases

## Setup
- have syllabus open to Postgres Intro
- cd into cohort-lecture-examples
- make sure you are on main branch
- $ git branch & delete any stale branches
- $ touch postgresql-intro.md
- $ code .

## Lecture

To start talking about databases, let's revisit a class - just as an example.  Let's say I'm keeping track of students and which cohort they are in.  The Class would look like this:
```ruby
class Student
  def initialize(name, cohort)
  @name = name
  @cohort = cohort
  end
end
```

Remember the class defines the structure of data and then I can create any number of instances with 
```ruby
Student.new('Felix', 'Bravo')
Student.new('Romeo', 'Hotel')
Student.new('Heath', 'Foxtrot')
```
I can make as many instances as I need.  As developers, when we create a class, we need to determine wht data is important and how to organize it. We're going to use the same idea in Databases to determine what the database will look like

## Databases
- way of storing data in an organized way
We will be using Postgres which is a Relational Database.  DB structured to recognize relations among stored items and they consist of rows and columns. Think Giant Excel Spreadsheet

We need two things when designing a database:
- what is the structure
- create actual data

First define the Model.  Model is the class in our example.  It will be a table called student where we need name and cohort
Then we can add an instance
Each row is an object - it is an instance in the database
- Model --> class
- row --> object

- each row is a UNIQUE instance.  Even if we have duplicate data, each object is unique. So say we have 2 rows with identical data?  We don't have variables that we could assign the different objects to.  But we do have is this column on the left which is called the PRIMARY_KEY.  PK is a unique identifier.  It is very common that it's a number (but not always) and it gives each row/object a different id.

quick review - For DBs, Model is like a class - doesn't do anything, it defines the columns and types of data stored.  Each row is a set of information, it is an instance in the Model class.

# Postgresql

Let's talk specifically about postgresql

In programming, there are different categories of languages.  One is general purpose programming languages. These include JS, Ruby, and others. They do logic.
Then we have domain specific languages. Examples include HTML - language for the web application domain. The RSpec testing tool was created to test Ruby code. 
Postgres's job is to talk to databases.

- it is open-source
- it is an Object-Relational Database Mgmt System
- takes an OOP approach to programming

- it has been installed on all your machines. You can go to your terminal - 
no matter where you are in the filetree - and type `psql` you will enter the postgres console. (Similar to IRB in that way - you can access from whereever in the terminal)
- type `psql`
- type `\l` - this will show all the dbs on your machine
- each database on your personal computer is unique and cannot be shared. Repeat!

A database is an empty storage space.  We can add tables.  I don't want to work in this console because it's a bit difficult and clunky.  We'll instead use a tool that provides a visual way to interact with the db.

You all have an elephant icon in your mac toolbar - click on that and you'll get the UI to work with our databases.  This is called pgAdmin.  Just use your computer login(SDlearn123) when asks for password







