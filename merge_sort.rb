class Array
  def merge_sort(&prc)
    prc ||= Proc.new { |a,b| a<=>b }
    return self if self.length == 1
    mid = self.length/2
    left = self[0...mid].merge_sort(&prc)
    right = self[mid..-1].merge_sort(&prc)
    merge(left, right, &prc)
  end

  def merge(left, rigth, &prc)
    prc ||= Proc.new{ |a,b| a<=>b }
    result = []
    until left.empty? || rigth.empty?
      small = prc.call(left[0], rigth[0])
      if small < 1
        result << left.shift
      else
        result << right.shift
      end
    end
    result+left+right
  end

end
