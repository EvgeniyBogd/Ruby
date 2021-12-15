module Validation
  def self.included(base)
    base.extend ClassMethods
    base.include InstanceMethods
  end

  module ClassMethods
    def validate(name, *options)
      @@validations ||= []
      @@validations << {name: name, options: options}
    end
  end

  module InstanceMethods
    def validate!
      self.class.validate.each do |validation|
      attr = instance_variable_get("#{validation[name]}".to_sym)
        if attr == "" || attr.nil?
        raise "Empty value "
        elsif attr[:format] !~ format
        raise "Incorrect format"
        elsif attr[:type].is_a?(type)
        raise "Incorrect type"
        end
      end
    end


    def valid?
      validate!
      true
    rescue StandardError
      false
    end
  end
end
