#OBJECT-ORIENTED PROGRAMMING

#IRB - interactive ruby
# everything in Ruby is an object.
# meaning each object is an instance of class
#therefore everything in ruby is an instance of class
#open irb
#type String.class
#     Number.class
#     Hash.class
#
# Once you know what class the object belongs to you can check it's methods.
# String.methods
# Look at all these methods. Honestly,I'd need to look up most of these. Thank goodness for Google.
# Let's grab one that I know.
# str = 'Bravo'
# str.include? 'br'
# str.include? 'B'

# everything is described in a heirarchy of objects that belong to classes
# any rule I write is goverend by rules of all Strings - how it's created, updated, etc.
#when we create a class, we are writing the rules
# ruby has a method for declaring new instances of Classes with unique data called
  #  initialize
    # initialize takes as many parameters as we desire and can use any of them as we desire


    class Netflix
      attr_accessor :title, :run_time, :watched
    
      def initialize(title, run_time)
        @title = title
        @run_time = run_time
        @watched = false
      end
      def get_show_data
        if @watched
          "You have watched the show #{@title} which is #{@run_time} minutes long."
        else
          "You have not watched the show #{@title} which is #{@run_time} minutes long. Wanna start?"
        end
      end
    end
#
# what apps have title, runtime, whether you consumed, liked
# streaming video
# streaming internet (youTube - like, comment, describe, playlists, channel)
#streaming music(Spotify - sections/genres, stations, queue, radio)

#Inheritance allows classes to have relationships with each other.
# With inheritance, classes can share behaviors making code more efficient.
#Putting common behaviors into a shared class is creating a superclass.
  # SuperClass has attributes that are common to all possible subclass
  # SubClass has attributes that are specific to the subclass and not the other subclasses of the class.




# Superclass - holds common behaviors of shared classes
# then passes info to subclass
class StreamingApp
  attr_accessor :title, :run_time, :consumed_media
  def initialize(title, run_time)
    @title = title
    @run_time = run_time
    @consumed_media = false
  end
  def show_data
    if @consumed_media
      "You have consumed the media  #{@title} which is #{@run_time}."
    else
      "You have NOT consumed the media  #{@title} which is #{@run_time}."
    end
  end
end

# SubClasses use the method super().  In the SubClass, the initialize invokes the super method, which tells the Superclass "hey I'm going to use your initalize method and borrow your instance variables"  The arguments you pass to the new instance of your subclass will be the exact same arguments passed to super.  instance variables are not inherited from parent classes



class YouTube < StreamingApp
  def initialize(title_parameter, run_time_parameter, creator_parameter)
    #when create a new instance, need to pass info back up to streaming app
    super(title_parameter, run_time_parameter)
    #super passes whatever it's passed back up to Superclass. Universal to OOP.
    #youtube app has ytoutube studio,  which means it takes in another param => creator
    @creator = creator_parameter
  end
end

friday = YouTube.new("Friday", "3:48", "Rebecca Black")

p friday

class Spotify < StreamingApp
  def initialize(title_parameter, run_time_parameter, artist_parameter, genre_parameter)
    super(title_parameter, run_time_parameter)
    # how to save those new parameters unique to this SubClass?
    @artist = artist_parameter
    @genre = genre_parameter
    # instance variable will be accessible to entire instance of the class. it is an instance variable assigned to a parameter that I'm taking in.
  end
    #let's make a getter method that gets all this info in one nice clean stream.
  def get_info
    # well we can just use the SuperClass method 'show_data' and append more data
    show_data + "This media was created by #{@artist} and belongs to the genre #{@genre}"
  end
end

doja_cat = Spotify.new("Woman", "40:20", "Doja Cat", "Pop")

p doja_cat.get_info

#how do you update the method to say we watched/listened?
doja_cat.consumed_media = true

#what is the symbol for the subclass inheritance to the Superclass in classes
# what is the method that passes params back up to SuperClass to be used? super
# if I need to make change to all my SubClasses, where do I make that change, where do I do it?
# what method do I use to instantiate the SubClass
