module Validation
  def self.included(base)                # создание метода класса
    base.extend ClassMethods             # который на уровне класса подключает модуль ClassMethods
    base.include InstanceMethods         # на уровне экземпляра класса подключает модуль InstanceMethods
  end

  module ClassMethods
    def validate(name, type, *param)                              # создание метода который принимает обязательные значения name, type  и необязательные значения в неограниченном количестве
      @validate ||= []                                            # выводит значение переменной класса, если переменная класса не установлена, устанавливает ее равной пустому массиву
      @validate << {name: name, type: type, param: param}         # помещает в переменную класса значения
    end
  end

  module InstanceMethods
    def valid?                                  # создание метода, результатом которого будет логическое выражение
      validate!                                 # если медод validate! выполняется
      true                                      # возвращает true
    rescue RuntimeError                         # выбрасывает исключение RuntimeError
      false                                     # возвращает false
    end

    private

    def validate!                                                      # метод изменения
      self.class.instance_variable_get("@validate").each do |hash|     # вызов перебора инстанс переменной имеющей значение массива @validate на уровне класса с параметром hash
        name = hash[:name]                                             # установление локальной переменной name равной значению :name параметра hash
        value = instance_variable_get("@#{name}")                      # установление локальной переменной value равной значению инстанс переменной
        type = hash[:type]                                             # установление локальной переменной type равной значению :type параметра hash
        param = hash[:param][0]                                        # установление локальной переменной param равной значению :param с нулевым значение по умолчанию параметра hash
        send("validate_#{type}", name, value, param)                   # вызов метода с параметрами
      end
    end

    def validate_presence(name, value, _)                                       # метод который принимает значения name, value ( " _ " это видимо возможность принять еще значения, не уверен)
      raise "#{name} should be present!" if value.nil? || value.to_s.empty?     # выбрасывает исключение с текстом если значение value nil или value имеет пустое значение (оба утверждения неравнозначны разве в данном случе)
    end

    def validate_format(name, value, regexp)                                    # метод который принимает значения name, value, regexp
      raise "Format #{name} should be #{regexp}!" if value !~ regexp            # выбрасывает исключение с текстом если value не эквивалентно regexp (откуда берется regexp, вручную?)
    end

    def validate_type(name, value, type)                                        # метод который принимает значения name, value, type
      raise "Type #{name} should be #{type}" unless value.is_a?(type)           # выбрасывает исключение с текстом до тех пор пока value не будет равно type
    end

    def validate_positive(name, value, _)                                       # метод который принимает значения name, value
      raise "#{name} should be positive" unless value.positive?                 # выбрасывает исключение с текстом до тек пор  пока value имеет отрицательное значение
    end

    def validate_length(name, value, param)                                                 # метод который принимает значения name, value, param
      raise "Length of #{name} should be at least #{param}" if value.length < param         # выбрасывает исключение с текстом если длина value меньше param
    end
  end
end
