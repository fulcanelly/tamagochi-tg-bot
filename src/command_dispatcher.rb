class CommandDispatcher 
  
  def self::no_element(*args)
    puts "get unknown stuff for " + args.to_s
  end

  def initialize(default = self::class::method(:no_element))    
    @commands = if default.is_a? Hash then default else Hash.new(default) end
  end

  def register_command(name, method) 
    @commands[name] = method
    return self
  end

  def overturn_method(name, source)
    meth_name = ("on_" + name.sub('/', '')).to_sym
    register_command(name, source.method(meth_name))
  end

  def match(text, *args)
    meth = @commands[text]
    puts "got to run #{meth.to_s.red}"
    meth.call(*args)
  end

end