puts "Укажете длину первой стороны треугольника"
a = gets.chomp.to_i


puts "Укажете длину второй стороны треугольника"
b = gets.chomp.to_i


puts "Укажете длину третьей стороны треугольника"
c = gets.chomp.to_i

a,b,c = [a, b, c].sort

if a == b && a == c
  puts "Треугольник равносторонний"
elsif a == b || a == c || b == c
  puts "Треугольник равнобедренный"
elsif c == Math.sqrt(a**2 + b**2)
    puts "Треугольник прямоугольный"
else
 puts "Обычный треугольник"  
end      
