# Active Record Validations and Model Specs

# Setup

- $ `rails new validations -d postgresql -T`

# Lecture

Validations are added to the model class and will run each time you create or update the instance. They will ensure that only clean and valid data gets saved into the database. Rails will run all model validations before content is added to the database. If these validations produce any errors the content will not be saved.

When working with the countries db last week, we had a few times when we were dealing with a lot of null values. Remember Null behaves differently than 0. It is not good practice to structure your database to have multiple null values in a column.

When creating the database, we want to be thoughtful of the structure as well as the actual data being provided. We want to be careful to prevent a user from adding incorrect data. Sometimes this can be accidental, and sometimes malicious.

Validations ensure that the data that gets passed in is what we are expecting.

- $ cd validations
- $ cd rails db:create

# Adding RSpec

We know that we pass the flag -T when creating a new app and this drops the testing library that comes with rails. Now we are going to install Rspec so we can write tests for our Rails app.

Let's look at the syllabus for the proper steps for the install

1. Add the dependencies for RSpec

- $ bundle add rspec-rails
- bundle indicates that I'm interacting with the gem file

2. $ rails g rspec:install

- we know that running a generate command creates files and folders specific to what we pass it, in this case Rspec

Now we have a new folder in here labeled `spec` which will hold our RSpec tests.

# Data

First we want to generate a model with appropriate columns and data types

- $ rails g model Animal name:string age:integer

It's important to setup RSpec BEFORE generating the model so rails automatically generates a spec file for us. Otherwise, we will have to create the file ourselves (which is fine, just not efficient)

We can also see that we have a new folder in our spec folder called models which has a spec file in there.
We can see that there is already a test in here. There is a describe and a block.

Let's start by just checking if it is running correctly.

- $ rspec spec/models/animal_spec.rb $ This shows me a few useful things. First I need to migrate my database, but it also shows that it is finding the file.

- $ rails db:migrate
- $ rspec spec/models/animal_spec.rb

This shows i have a pending test, which is straight out of the box. Let's get rid of the pending line and write some real tests.

# Tests

The first test will be vague, but it's checking that I can make an instance in my db.

```ruby
RSpec.describe Animal, type: :model do
  it 'is valid with valid attributes' do
    cat = Animal.create(name:'Cat', age:'5')
    expect(cat).to be_valid
  end
end
```

Line 5 is like going into my rails console and creating an instance of Animal, cat.

- $ rails c
- $ cat = Animal.create(name:'Kevin', age:'5')
- $ cat.valid?
  => true
  What if I just type Animal.create in my console...?
- $ Animal.create
  I get nil values - not what I want. Currently, I have nothing to stop nil values from being added. So we want to start adding protection on the columns that specifies data must be provided or entry will be rejected. This will be our next test and we will practice red-green-refactor.

```bash
#<Animal:0x0000000109ed9d88
 id: 2,
 name: nil,
 age: nil,
 created_at: Sun, 20 Aug 2023 17:55:27.943860000 UTC +00:00,
 updated_at: Sun, 20 Aug 2023 17:55:27.943860000 UTC +00:00>
```

- cat.errors

```bash
3.2.0 :005 > cat.errors
 => #<ActiveModel::Errors []>
```

- cat.errors.empty?

You can see that we an empty array is returned. This means there are no errors. But we want an error, right? We want it to Rails to tell us, "Hey, you are missing some data."

Ok, we want each column to have data, so our next expect statement will check if it has a name, and if not, it is not valid. That is, we are checking that if an instance is missing a name, Rails will throw an error.

```ruby
 it 'is not valid without a name' do
    cat = Animal.create(age: 5)
    expect(cat.errors[:name]).to_not be_empty
  end
```

Currently this fails because our app is not setup to create an error if I don't pass all the data. Right now it's saying 'anything goes'. This is a good failure.

```bash
1) Animal is not valid without a name
     Failure/Error: expect(cat.errors[:name]).to_not be_empty
       expected `[].empty?` to be falsey, got true
     # ./spec/models/animal_spec.rb:11:in `block (2 levels) in <top (required)>'

```

To show you, we'll check in the console

```bash
3.2.0 :003 > cat.errors[:name]
 => []
3.2.0 :004 >
```

Now let's tell our app that we don't want that to be allowed. The user must provide some name data or we want it to throw an error.

This is when we set up some validations.
This will be inside our model class - the same place we set up associations.

We will add a line that is going to validate the presence of data in a particular column.

```ruby
app/models/animal.rb

class Animal < ApplicationRecord
  validates :name, presence: true
end
```

And now we are passing. Let's take a closer look at this.

**_ DON'T FORGET TO EXIT RAILS C _**

- $ rails c
- $ cat = Animal.create age:7
- $ cat

```bash
#<Animal:0x00000001073d2ef0
 id: nil,
 name: nil,
 age: 7,
 created_at: nil,
 updated_at: nil>
```

This time around, cat never got created. I know this because the id is nil.
-$ cat.errors

```bash
3.2.0 :003 > cat.errors
 => #<ActiveModel::Errors [#<ActiveModel::Error attribute=name, type=blank, options={}>]>
```

I can also see that there are errors in my array this time around. We can also pull out errors specifically tied to the name column

```bash
3.2.0 :004 > cat.errors[:name]
 => ["can't be blank"]
3.2.0 :005 >
```

- $ cat.errors[:name]
  This is how you access a single item from a hash. By using the square brackets and passing in the key of the hash We get back an error message in the array "can't be blank" $

So realistically, writing tests has a little bit of a backwards thinking. We have to think of the end result and then work backwards from there.

Let's write another test. Just like we validated name and tested that name must have some content provided, let's write a test that checks that our age column is valid.

```ruby
  it 'is not valid without an age' do
    cat = Animal.create(name:'Kevin')
    expect(cat.errors[:name]).to_not be_empty
  end
```

The test is failing (good fail), so let's add the validation

```ruby
class Animal < ApplicationRecord
  validates :name, presence: true
  validates :age, presence: true
end
```

Now the test passes!

# More Validations

Go to Active Record Validations link in syllabus

Let's use the length validation using range

```ruby
  it 'is not valid if name is outside of 2-20 characters' do
    cat = Animal.create(name:'C', age:5)
    expect(cat.errors[:name]).to_not be_empty
  end
```

Good fail!
Validations:

```ruby
app/models/animal.rb

 class Animal < ApplicationRecord
  validates :name, :age, presence: true
  validates :name, length: { in: 2..20 }
end
```

Now we need just one more validation - the other side of the range
Let's just add it to the range test we already have

```ruby
  it 'is not valid if name is outside of 2-20 characters' do
    cat = Animal.create(name:'C', age:5)
    expect(cat.errors[:name]).to_not be_empty

    long_cat = Animal.create(name:'Kevin the One-Armed WonderCat!', age:1)
    expect(long_cat.errors[:name].to_not be_empty
  end
```

Uniqueness

```ruby
  it 'is not valid without a phone number' do
    cat = Animal.create(name:'Kevin', age:9)
    expect(cat.errors[:phone]).to_not be_empty
  end

  it 'is not valid with duplicate phone number' do
    cat = Animal.create(name:'Kevin', age: 9, phone: '555-1212')
    dupe = Animal.create(name:'Kevin', age: 9, phone: '555-1212')
    expect(dupe.errors[:phone]).to_not be_empty
  end
```

The challenges are going to require you to jump between a few different lessons we have gone through recently. The stretch challenges will require some further research that is not directly in the syllabus. There are some resources provided. A HUGE tip from someone who learned the hard way: ALWAYS, ALWAYS use the documentation FIRST, before you just look for answers on stack overflow. The documentation will help you understand rather than just copy someone else's code. Which will not help you later.
