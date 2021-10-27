puts "Введите год!"
year = gets.chomp.to_i

puts "Введите месяц по порядку!"
month = gets.chomp.to_i

puts "Введите число!"
day = gets.chomp.to_i

if day <= 31 && month <= 12
  if year % 4 == 0 || year % 400 == 0
    a_day = [31, 29, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
  else
    a_day = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
  end

a_month = (1..12).to_a

day_hash = a_month.zip(a_day).to_h
month_b = month - 1
a = [0]	
m = (1..month_b)
m.each do |n|
	a.push(day_hash[n])
end

today = a.sum + day	 


  puts today
else
	puts "Nothing"
end	