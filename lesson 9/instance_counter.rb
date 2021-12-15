# frozen_string_literal: true

module InstanceCounter
  def self.included(base)
    base.extend ClassMethods
    base.include InstanceMethods
  end

  module ClassMethods
    attr_accessor :all_instances

    def instances
      all_instances
    end
  end

  module InstanceMethods
    private

    def register_instance
      self.class.all_instances ||= 0
      self.class.all_instances += 1
    end
  end
end
