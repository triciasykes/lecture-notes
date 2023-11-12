# Active Record Migrations

When you hear the word migration, what do you think of?
I often associate the word migration of changing a location. In databases, sometimes we are going to need to change our schema. Sometimes it is because we made a mistake when creating our tables, we need to adjust a data type in a column, or we are adding new columns because we are expanding our application.

For whichever reason, we can't just go into our schema and start typing stuff in there. That would make our application very vulnerable.

This is where migrations are going to be our friend!

Let's get set up first:

## Process

    - Set up environment with git
      - $ git status
      - $ git branch
      - remove stale branches
      - $ git pull origin main
      - $ git checkout -b active-record-migrations
    - $ touch active-record-migrations.md

Today when we build our apps, we are NOT pushing the rails app to our challenge repo! We will be saving our work in a markdown file. The rails app will not be saved on git this time around.

Let's head on over to our syllabus and head to Active Record Migrations

- Before we start migrating things, we need to have a rails app and a database to work with first. So let's do that

  - Scroll down on the syllabus to where it has Creating a Migration.

    - Copy/Paste terminal commands:
      $ rails new learn_band -d postgresql -T
      $ cd learn_band
      $ rails db:create
      $ rails server
    - Open text editor so that rails app is visible

    - Let's now generate a model

      - $ rails generate model BandMember name:string instrument:string

    - This will generate a migration file that will help us build a database schema.
    - If I look in my db folder though, schema does not exist. I simply have a migration file that says create_bandmembers
    - This is where I need to run a migration to tell my database that I want to implement that change to my database
      - $ rails db:migrate

  - Now our database is created, and we have migrated our model so that now it exists in our schema. We can now start adding some data into our database in our rails console.

    - $ rails c

```ruby
    > BandMember.create name: "Elyse", instrument: "Keyboard"
    > BandMember.create name: "Sarah", instrument: "Cowbell"
    > BandMember.create name: "Austin", instrument: "Guitar"
    > BandMember.create name: "Samir", instrument: "Vocalist"
    > BandMember.create name: "Zane", instrument: "DJ"
```

    - To see all of the members:

```ruby
        > BandMember.all
```

    - Rails will automatically create a unique id for each instance.  What is this id called?  Primary key!

## Adding a Column

- Our band is starting to take off and we want to start tracking how much each band member charges. To do this, we need to add a column to our table

  - $ rails generate migration add_column_pay_to_band_member

  The naming convention for this command is for your reference and does not actually make any change. You can use snake case or pascal case when naming this, just keep it consistent.

  - To make the change to our database, we need to add some things to this migration file we just generated.

  - Go to syllabus and click on change definitions link

```ruby
    def change
        add_column :band_members, :pay, :integer
    end
```

- The order is important here! Use our change definition, model we are updating, column we are adding, data type of new column.

- Let's update our database with this change!

- $ rails db:migrate

# Rename a Column

- So we realized that pay was a little vague and want to be more specific. Let's change pay to be hourly pay.

- $ rails generate migration change_name_of_pay_to_hourly_pay

```ruby
    def change
        rename_column :band_members, :pay, :hourly_pay
    end
```

Use our change definition, model, column we renaming, new name of column

- $ rails db:migrate

Great! Now when we run BandMember.all we see that our pay is nil.

Let's practice updating this.

    > elyse = BandMember.find 1
    > elyse.update hourly_pay:500

# Update Data Type

Let's say we want to change our data type from integer to float so we can be more precise with our pay scale. We can run another migration

- $ rails generate migration change_data_type_of_pay_to_float

```ruby
    def change
        change_column :band_members, :hourly_pay, :float
    end
```

An important note: Do NOT modify your migration files after you have migrated them into your schema! This can cause some really crazy errors and can become very difficult to fix. Do not delete migration files either. Your application requires each of those files to know how to build your database.
