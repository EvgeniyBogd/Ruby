# frozen_string_literal: true

module Accessors
  def self.included(base)
    base.extend ClassMethods
  end

  module ClassMethods
    def attr_accessor_with_history(*attrs)
      attrs.each do |attr|
        attr_name = "@#{attr}".to_sym
        attr_hist_name = "#{attr_name}_history"
        define_method(attr) { instance_variable_get(attr_name) }
        define_method("#{attr}_history".to_sym) { instance_variable_get(attr_hist_name) || [] }
        define_method("#{attr}=".to_sym) do |value|
          instance_variable_set(attr_name, value)
          instance_variable_set(attr_hist_name, send("#{attr}_history".to_sym) << value)
        end
      end
    end

    def strong_attr_accessor(name, value_class)
      attr_name = "@#{name}".to_sym
      define_method(name) { instance_variable_get(attr_name) }
      define_method("#{name}=") do |value|
        if value.is_a? value_class
          instance_variable_set(attr_name, value)
        else
          raise TypeError 'Incorrect class'
        end
      end
    end
  end
end
