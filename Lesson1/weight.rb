puts "Как тебя зовут?"
name = gets.chomp

puts "Какой у тебя рост?"
height = gets.chomp



weight = (height.to_i - 110) * 1.15

if weight >=0
  puts "#{name}, привет! Твой идеальный вес #{weight}!" 
else
  puts "#{name}, привет! Ваш вес уже оптимален!" 
end