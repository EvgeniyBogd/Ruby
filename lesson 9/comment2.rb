# frozen_string_literal: true

module Validation
  ERRORS = { |variable|                                     # создание константы ERRORS равной хэшу с параметром variable
    blank: '%s is nil or empty!',                           # где ключами явлеятся тип проверяемого значения, а значением текст сообщения об ошибке
    format: '%s does not match the pattern!',
    type: '%s - incorrect class type!'
  }.freeze

  def self.included(base)                             # создание метода класса
    base.extend ClassMethods                          # который на уровне класса подключает модуль ClassMethods
    base.include InstanceMethods                      # на уровне экземпляра класса подключает модуль InstanceMethods
  end

  module ClassMethods
    def validate(name, type, param = nil)                             # создание метода который принимает обязательные значения name, type  и param, который по умолчанию установлен пустым
      @validations ||= []                                             # выводит значение переменной класса, если переменная класса не установлена, устанавливает ее равной пустому массиву
      @validations << { name: name, type: type, param: param }        # помещает в переменную класса значения
    end
  end

  module InstanceMethods
    def valid?                                      # создание метода, результатом которого будет логическое выражение
      validate!                                     # если медод validate! выполняется
      true                                          # возвращает true
    rescue RuntimeError => e                        # выбрасывает исключение RuntimeError и помещает его в переменную е
      puts e.message                                # выводит текст сообщения исключения
      false                                         # возвращает false
    end

    protected                                       # дальнейший блок становится непубличным

    def validate!
      validations_class = child? ? self.class.superclass : self.class                                   # устанавливает значение локальной переменной validations_class если метод child? выполняется... (дальше не очень понятная контрукция про вызов метода класс)
      errors = extract_validations(validations_class.instance_variable_get('@validations'.to_sym))      # устанавливает значение локальной переменной errors равной методу extract_validations со сзначением (опять не совсем понятная структура вывода инстанс переменной)
      raise errors.join("\n") unless errors.empty?                                                      # выбрасывает исключение  с преобразованием всех значений errors в строку до тех пор пока errors не пуста
    end

    def extract_validations(validations)                                                # создание метода который принимает значение
      validations.each_with_object([]) do |opts, errors|                                # перебор принятого значения с созданием объекта со значением ввиде пустого массива по параметрам opts, errors
        value = instance_variable_get("@#{opts[:name]}".to_sym)                         # устанавливает значение локальной переменной value равное инстанс переменной, определенной как значение :name параметра opts
        errors << send("#{opts[:type]}_validate".to_sym, opts.merge(value: value))      # помещает в константу тип валидации, в параметр opts помещает ключ/значение value: value
      end.compact                                                                       # (compact??)
    end

    def child?                                                                          # создание метода, результатом которого будет логическое выражение
      self.class.superclass != Object                                                   # метод класса ....()  не эквивлент Object (что это не совсем понятно)
    end
  end

  protected

  def presence_validate(opts)                                                                    # создание метода который принимает значение
    ERRORS[:blank] % opts[:name] if opts[:value].nil? || opts[:value].to_s.strip.empty?          # значение константы по ключу :blank делится на значение ключа :name принимаемого в методе значения, если ключ :value ноли или пустой
  end

  def format_validate(opts)                                                                      # создание метода который принимает значение
    ERRORS[:format] % opts[:name] if opts[:value] !~ opts[:param]                                # значение константы по ключу :format делится на значение ключа :name принимаемого в методе значения, если ключ :value не эквивлент ключу :param
  end

  def type_validate(opts)                                                                        # создание метода который принимает значение
    ERRORS[:type] % opts[:value].class unless opts[:value].is_a? opts[:param]                    # значение константы по ключу :type делится на значение ключа :value принимаемого в методе значения до тех пор пока :value не будет включать в себя :param
end                                                                                              # (здесь не совсем понятена функция оператора %)
