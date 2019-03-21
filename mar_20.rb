def merge(left, right, &prc)
  prc ||= Proc.new { |a,b| a<=>b }
  result = []
  until left.empty? || right.empty?
    if prc.call(left[0], right[0]) < 0
      result << left.shift
    else
      result << right.shift
    end
  end
  result+left+right
  end
end
