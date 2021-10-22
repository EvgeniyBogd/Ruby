puts "Введите коэффициент a:"
a = gets.chomp.to_f

puts "Введите коэффициент b:"
b = gets.chomp.to_f

puts "Введите коэффициент c:"
c = gets.chomp.to_f

D = b**2 - 4 * a * c

X = -b / 2 * a

X1 = (-b + Math.sqrt(D)) / 2 * a

X2 = (-b - Math.sqrt(D)) / 2 * a  

if D > 0
  puts "Дискриминант равен #{D}. Корень 1 равен #{X1}. Корень 2 равен #{X2}."
elsif D = 0
  puts "Дискриминант равен #{D}. Корень равен #{X}."	
else
  puts 	"Дискриминант равен #{D}. Корней нет."
end  


