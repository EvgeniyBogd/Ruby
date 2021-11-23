module InstanceCounter

  def self.included(base)
    base.include(ClassMetod)
    base.extend(InstanceMetod) 
  end    
  
  module ClassMetod
    def count
        @count ||= 0
    end
  end

  module InstanceMetod
    protected
     def add_instance
      self.class.count += 1
    end
  end
end