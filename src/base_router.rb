require_relative 'container'

class BaseRouter < Struct.new(:db)
    public
      
    include Container
  
    def on_default()
      throw "not implemented route"
    end
  
    def is_a_router?
      true
    end
  
    protected
  
    def run(route)
    end
  
    def plan(route)  
    end
  
    def restricted_routes()
      []
    end
    
  end
  