purchase = {}
n = 0

loop do
 puts " Введите название товара. Чтобы прекратить выбор товара наберите 'Стоп'!"
  product = gets.chomp
break if product == "Стоп" || product == "стоп"

puts "Укажите цену за единицу товара!"
price = gets.chomp.to_f


puts "Укажите количество товара!"
num = gets.chomp.to_f


n = n + price*num

purchase[product] = {price: price, num: num}
end
 
 purchase.each do |k, v|
	puts "Выбранный товар: #{k}, стоимость: #{v[:price]}, количество #{v[:num]}, общая стоимость товара: #{v[:price]*v[:num]}"

end

puts "Итого: #{n}"