module Container 
  attr_accessor :bot
  attr_accessor :char_db

  private
  def get_self_of_any(*_, **_)
    self 
  end

  public 

  def set_bot(bot)
    get_self_of_any self.bot = bot
  end

  def set_char_db(db)
    get_self_of_any self.char_db = db
  end
end