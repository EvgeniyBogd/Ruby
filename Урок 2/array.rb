array = (10..100)
new_array = array.to_a.select { |x| x % 5 == 0 }
puts new_array
