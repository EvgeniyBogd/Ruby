module Validation
  def self.included(base)
    base.extend ClassMethods
    base.include InstanceMethods
  end

  module ClassMethods
    def validate(variable_name, validation_type, validation_options=nil)
      @validations ||= []
      @validations << { variable_name: variable_name, validation_type: validation_type, validation_options: validation_options }
    end
  end

  module InstanceMethods
    def validate!
      self.class.instance_variable_get('@validations').each do |validation|
        var = instance_variable_get("@#{validation[:variable_name]}")
        case validation[:validation_type]
        when :presence
          raise "#{"@#{validation[:variable_name]}"} can't be nil" if var.nil?
        when :type
          raise "#{"@#{validation[:variable_name]}"} should be #{validation[:validation_options]}" unless var.is_a?(validation[:validation_options])
        when :format
          raise "#{"@#{validation[:variable_name]}"} should be #{validation[:validation_options]}" if var !~ validation[:validation_options]
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
