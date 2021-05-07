require 'colorize'

def puts(data) 
  super(
    Time.now.strftime("[%k:%M:%S]") +
    "[INFO]".green + 
    ": " + data.to_s  
  )
end

module Kernel 
  def to_b
    not not self
  end
end

class Hash
  def method_missing(name, *args, **nargs, &block)
    if self.include?(name) 
      self[name]
    else 
      super(name, *args, **nargs, &block)
    end
  end

end

puts "loading libs"

require 'sqlite3'
require 'telegram/bot'

puts "setting up things"

token = '1715552411:AAFEkatMJOBvkfDsua5t0boV9_JEXbJqj0w'

db = SQLite3::Database.new "game.db"


class PlayerManager 
end



class CharacterManager < Struct.new(:db)

    def setup_tables()
      puts "setting up tables of " + self.to_s
      db.execute <<-SQL
        CREATE TABLE IF NOT EXISTS characters(
          name text,
          user_id int,
          chat_id int
        );
      SQL
    end

    def is_user_have_character?(user_id)
      (db.execute "SELECT * FROM characters WHERE user_id = ? LIMIT 1", user_id).first.to_b
    end

    def add_character(name:, user_id:, chat_id:)
      db.execute "INSERT INTO characters VALUES(?, ?, ?)", [name, user_id, chat_id]
    end

    
end

char_db = CharacterManager.new(db)
  .tap(&:setup_tables)
  

class CharacterFeeder
end



require_relative 'src/handlers'
require_relative 'src/command_dispatcher'


def is_end(line)
  if line == "e" then 
    puts "exiting"
    exit
  end
end

Thread.new do 
  nil until is_end(gets.chop)
end

base_events = GameCommandEventsHandler.new()
  
dispatcher = CommandDispatcher.new()
  .overturn_method("/help", base_events)
  .overturn_method("/obtain_character", base_events)

puts "starting bot"





Telegram::Bot::Client.run(token) do |bot|
  base_events.set_bot(bot)
  base_events.set_char_db(char_db)
  bot.listen do |message|
    p message.from.id
    dispatcher.match(message.text, message)
  end
end



