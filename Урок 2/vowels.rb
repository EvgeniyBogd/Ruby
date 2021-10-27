alf = ("а".."я").to_a
num = (1..100).to_a

h = alf.zip(num).to_h
vowels = h.select  {|l, n| l == "а" || l == "е" || l == "ы" || l == "о" || l == "э" || l == "я" || l == "и" || l == "ю"
}
print "#{vowels.to_a}"
