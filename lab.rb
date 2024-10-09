class User
    attr_accessor :name, :email, :password
  
    def initialize(name, email, password)
      @name = name
      @email = email
      @password = password
    end
  
    def enter_room(room)
      room.add_user(self)
    end
  
    def send_message(room, content)
      message = Message.new(self, room, content)
      room.broadcast(message)
    end
  
    def acknowledge_message(room, message)
      puts "#{name} acknowledges: #{message.content} in room #{room.name}"
    end
  end
  
  class Room
    attr_accessor :name, :description, :users
  
    def initialize(name, description)
      @name = name
      @description = description
      @users = []
    end
  
    def add_user(user)
      @users << user
      puts "#{user.name} has entered the room: #{@name}"
    end
  
    def broadcast(message)
      @users.each do |user|
        puts "#{user.name} received message: #{message.content} from #{message.user.name}"
      end
    end
  end
  
  class Message
    attr_accessor :user, :room, :content
  
    def initialize(user, room, content)
      @user = user
      @room = room
      @content = content
    end
  end

  user1 = User.new("Alice", "alice@example.com", "password123")
  user2 = User.new("Bob", "bob@example.com", "password456")
  
  room = Room.new("General Chat", "A room for general discussions")
  
  user1.enter_room(room)
  user2.enter_room(room)
  
  user1.send_message(room, "Hello everyone!")
  
  user2.acknowledge_message(room, Message.new(user1, room, "Hello everyone!"))
  