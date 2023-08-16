# Postgresql and Databases

- touch postgresql-intro.md
- code .
- have syllabus open

Let's revisit a class. Say I'm keeping track of students and which cohort they are in. Class would look like this:

```ruby
class Student
   def initialize(name, cohort)
   @name = name
   @cohort = cohort
   end
end
```

the class defines the structure of data and then I can create any number of instances with

```ruby
Student.new('Felix', 'Bravo')
Student.new('Evelyn', 'Bravo')
```

I can make as many instances as I need.
When we create a class, as a developer I need to determine what data is important and how to organize it. We're going to use the same idea in Databases to determine what the database will look like.

# Databases

- way of storing data in an organized way
  We will be using Postgres which is a Relational Database. DB structured to recognize relations among stored items and they consist of rows and columns. Think Giant Excel Spreadsheet

We need two things:

- what is the structure
- create actual data

First define the Model. Model is the class. It will be a table called student where we need name and cohort
Then we can add an instance
Each row is an object - it is an instance in the database

- Model --> class
- row --> object

- each row is a unique instance. Even if we have duplicate data, each object is unique. So say we have 2 rows with identical data?
  We don't have variables that we could assign the different objects to. But what we do have is this column on the left, which is called the primary_key. PK is a unique identifier. It's very common that it's a number (not always) and it gives each row /object a different id.

quick review - For DBs, Model is like a class - doesn't do anything, it defines the columns and types of data stored. Each row is a set of information, it is an instance in the Model class

# Postgresql

Let's talk specifically about postgresql

In programming, there are different categories of languages. One is general purpose programming languages. These include JS, Ruby and others. They do logic.  
 Then we have domain specific languages. Examples include HTML- language for the web application domain. Rspec testing tool that was created to test ruby code, Postgres's job is to talk to databases.

- it is opensource
- it is an Object-Relational Database Mgmt System
- takes an OOP approach to programming

- it has been installed on all your machines. You can go to your terminal - no matter where you are in the filetree - and type `psql` you'll enter into postgres console. It's like IRB in that way.
- type `psql`
- then `\l` will show all the dbs on your machine
- each database on your personal computer is unique and cannot be shared

a db is an empty storage space and then we can add tables
I don't want to work in this console because it's a bit clunky, instead we'll use a tool that provides a visual way to interact with the db.
You all have an elephant icon in your toolbar. Click on that and will get the user-interface to work with our databases
When it asks for a password, use your computer log in SDlearn123

**_ ACTIONS _**

- click into servers - you see I have access to localhost. remember this from React? This is our computer's server and therefore I'm able to access it by typing in localhost: and providing the port. Or you can type in the ip address which is the same on almost all networking systems: 127.0.0.1 (aka 'home')

- click localhost
- click databases
- you should see a db called countries. Click on countries (make sure you're on the dashboard view (top of toolbar))
- go to Tools on main menu
- Select Query Tool
- **_ Look at Postgres Queries in Syllabus _**
  Today we are going to interact with this data. Just like everything else, we are going to give it an input and get output. Our input will be the the db called countries. Our output will depend on what we write in this dialog box.
  Let's run the most basic query so you can see how this works. We want to see all the data in the db. We need to use postgres syntax. It is an older language and has a lot of documentation. Today you're going to get used to this synax by running queries!

Keywords are uppercase by convention.
We will start our query with `SELECT`. Select is a keyword that takes an argument. The argument will be the column header(s) you want

- - asterik or 'splat' means all. (also used in CSS)
- Then `FROM` what model are we querying. In this case it's country. countries is the name of the db. Model name is singular (class)
- Hit the play button top center of dialog box
- point out it returns 239 rows. Column on left is simply the row # (like a text editor). Notice we have column headers, with the name and tdatatype. Each row is an instance.

Notice in the code column there is a PK - what does that stand for? And what does that mean? unique identifier.

So we got back all the data. We made a request and got back all the data. But we don't need to return all the data for every query, right? Just the data we're interested in. There is a more efficient way.

`SELECT name, continent FROM country` this returns only what we need. Returns it as it's ordered in the table.

All the data: SELECT \* FROM country

SELECT name, continent
FROM country

SELECT name, continent, population
FROM country
LIMIT 10

**_ WHERE is a comparison operator _**
SELECT name, continent, population
FROM country
WHERE continent = 'North America'

SELECT name, continent, population
FROM country
WHERE continent != 'North America'

1e6 === 1000000, the number after the `e` represents how many decimal places you must move to the right.
2.381741e+06 = 2381741

SELECT name, continent, population
FROM country
WHERE population < 1e6

SELECT name, continent, population
FROM country
WHERE population < 1e6
AND continent = 'North America'

SELECT name, continent, population
FROM country
WHERE population < 1e6
OR continent = 'North America'

**_ LIKE used in WHERE clause to search for specified pattern in a column _**
**_ Using % called wildcard will be used in conjunction with LIKE _**
Using LIKE and wildcard to get back all the Americas:
SELECT name, continent, population
FROM country
WHERE continent LIKE '%America'

10 most recently independent countries:
SELECT name, region, indepyear
FROM country
WHERE indepyear IS NOT null
ORDER BY indepyear DESC
LIMIT 10
