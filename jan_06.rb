def url_short(num)
  array =('a'..'z').to_a + ('A'..'Z').to_a + (0..9).to_a
  result = []
  short_url = ""
  while num > 0
    ans = num % 62
    result.push(ans)
    num = num/62
  end
  result.reverse!
  result.each do |el|
    short_url << array[el]
  end
  short_url
end
url_short(125)

def long_url(string)
 array =('a'..'z').to_a + ('A'..'Z').to_a + (0..9).to_a
  num = ""
  result = 0
  string.chars.each do |str|
  num << array.index(str).to_s
  end
  i = 0
  while i < num.length
  result += num[i].to_i * (62 ** (num.length-1-i))
  i+=1
  end
  result
end
