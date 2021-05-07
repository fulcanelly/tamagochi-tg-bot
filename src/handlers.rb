require_relative 'base_router'
 
class DuelsActionHandler < BaseRouter

    def on_reject()
    end

    def on_consent()
    end 
end


class BotUitls
    
    def initialize(bot)
        @bot = bot
    end
    
    def answer(msg, text, **rest)
        @bot.api.send_message(chat_id: msg.from.id, text: text, **rest)
    end

end



class GameCommandEventsHandler < BaseRouter    

    def on_deuel_start() 
    end

    def on_help(msg) 
        puts "help"
    end

    def on_obtain_character(msg) 
        user_id = msg.from.id

        unless char_db.is_user_have_character?(user_id) 
            char_db.add_character(name: "character!", user_id: user_id, chat_id: msg.chat.id)
            bot.api.send_message(chat_id: user_id, text: "you got new character!")
        else
            bot.api.send_message(chat_id: user_id, text: "you already have character")
        end
    end

    def on_try_feed() 
    end

end


class ProxyCommandDispatcher 

    attr_accessor :obj, :name_filter

    def initialize(obj, &block)
        self.obj = obj 
        self.name_filter = if block_given? then block else self.method(:default_filter) end
    end

    def default_filter(name)
    end

    
    def method_missing(name, *args, **nargs, &block)
        puts "got for %s - %p %p %p" % [name, args, nargs, block]
    end

    
end
