# Active Record Associations Lecture Notes

Today we are going to talk about associations. We've been working in databases that have a table structure made of rows and columns.

We know in rails there's always going to be an id as one of the headers and you don't have to include it when creating your table, rails automatically adds the column and assigns the ids. Then we determine the name of each column and what datatype is associated with it. You can make as many columns as you like. Again - Excel Spreadsheet.

Let's make a cohort table and include the name of the cohort and then the students in that cohort.  What would it look like.
We have the cohort column and the id column with the primary key added by Rails. But what about the students? How would I list them all out? There are 21 students in this cohort. What if Foxtrot had 12? But I've created 21 columns to accommodate Delta? We would have a lot of NULL values in the Foxtrot row, which is never optimal. Or what if Golf had 30 students? Now we have to add columsn through migrations. What if I want to add students' email addresses to the database? Where would I do that?

None of these situations would lead us to a clean way to store data. To solve this problem, we can create a SECOND table for students.

This table will have its own primary key column for id, because rails adds that, and then I can have a column for name that takes datatype string. So now I can list out all the students, they all have individual ids and then I can tie specific instances in my student table to specific instances in my cohort table.

I can that I want the Monica instance to attach to Hotel, as well as Ney...
Then when I have someone from Foxtrot, I want this instance to attach to Foxtrot.

This then becomes a lot cleaner - I can put as many rows into my student database as I need and never have to worry about having it match up exactly class size-wise.  The way we make this connection in this column on the right. It is called a foreign key.

Now we have a primary key which is the unique identifier and a foreign key creates the connection between our two tables. In this case the foreign key would be called cohort_id (this is typical naming convention - the table name you're referencing, underscore id). Now anyone in the Hotel Cohort would get that particular cohort's id attached, and same for other students in other cohorts.  Now we can have as many rows as we need and we can describe the relationship between the cohort and the student using the foreign key.

This relationship, or association, is called has_many, belongs_to

The cohort has many students and students belong to a cohort.
the foreign key column will always live on the belongs_to table, and its data will be the primary key of the table we are connecting.

Are there any questions on this concept or anything you want to talk through?

The next question is how do we establish this relationship in code?

I've created a markdown file on the hotel-lecture-examples branch. I've written most of it out already, but will add some output from the console for reference. If you want me to add any notes along the way, just let me know.

On my desktop I'll build an app that I'll discard later.

`$ rails new associations -d postgresql -T` 

I do want to note that there are many type of active record associations - relationships between tables. Which one you use depends on what your data is doing and what the purpose is. For this introduction wer are going to focus on this has_many belongs_to association.

Lets code out the examples. 
- $ cd associations
- $ ls
- $ rails db:create

Now I need data. The foundation of any application is data. We want to save, extract, display, manipulate, do something with data.

Think of a cohort example, lets generate a model
`$ rails g model Cohort name:string year:string`
`$ rails db:migrate`

In the rails console I can do Cohort.all and it recognizes it exists
Let's open the text editor and check out the schema - cohort name and year are there

Now let's create a model for student because we decided earlier it will be it's own table with a relationship with cohort table

`$ rails g model Student name:string cohort_id:integer`
`$ rails db:migrate`

We are close! The schema is up to date. Now we have to define this relationship in our code:
Step 1 was createing a space for the relationship (ie, foreign key column)
Step 2 is to go into our app/models and tell the cohort class and the student class that they have a connection

Open cohort.rb

We define our relationship in the classes
```ruby
class Cohort < ApplicationRecord
  has_many :students
end
```
then in our student.rb
```ruby
class Student < ApplicationRecord
  belongs_to :cohort
end
```

Now we need to add some data. 
- create cohorts 
  Cohort.create(name:'Hotel', year:'2022')
  Cohort.create(name:'Foxtrot', year:'2022')
  Cohort.create(name:'Delta', year:'2022')

  Now we need to add students, but we have that foreign key column to think about. We have to put something in that column to create the relationship between the student and cohort. We don't want to directly manipulate those types of columns, similar to the primary key. Rails doesn't like that. Also, we'd have to know what cohort we're looking for to assign each student. let's pick a cohort and save it as a variable.

  hotel = Cohort.find(1)
  hotel.students ===> notice we get an empty array so we know they are linked.

  students.create(name:'Torin')
   ==> rails rejects it - it won't be saved. Why?  No foreign key

  But if we do this:

  hotel.students.create('Torin')
  hotel.students.create('Dom')

  foxtrot = Cohort.find(2)

foxtrot.students.create(name:”Matthew")
foxtrot.students.create(name:”Joseph”)




