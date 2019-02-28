# obj = {a: 10, b: {c: 1,d: 4, e: {k:5, g: 9}}, u: 1}

def find_value(obj, val)
  obj.each do |k,v|
    return true if v == val
    if (v.class == Hash)
      return true if find_value(v, val)
    end
  end
  false
end

p find_value({a: 10, b: {c: 1,d: 4, e: {k:5, g: 9}}},1)
p find_value({a: {b:10},c: {d:5}},10)
