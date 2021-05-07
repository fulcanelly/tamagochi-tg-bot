require_relative 'base_router'
 
class DuelsActionHandler < BaseRouter

    def on_reject()
    end

    def on_consent()
    end 
end

class GameCommandEventsHandler < BaseRouter

    def on_deuel_start() 
    end

    def on_help(msg) 
        puts "help"
    end

    def on_obtain_charracter(msg) 
        #IF HZ
      puts char_db.is_user_have_character?(msg.from.id).to_b.to_s.blue
      bot.api.send_message(chat_id: msg.from.id, text: "loh")
       # puts 'obtain_charracter'
    end

    def on_try_feed() 
    end

end