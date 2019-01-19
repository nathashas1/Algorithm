class Array
  def merge_sort(&prc)
    prc ||= Proc.new {|a,b| a<=>b }
    return self if self.length == 1
    mid = self.length/2
    left = self[0...mid].merge_sort
    right = self[mid..-1].merge_sort
    merge(left, right, &prc)
  end

  def merge(&prc)
    result = []
    until left.empty? || right.empty?
      if prc.call(left[0], right[0]) < 0
        result << left.shift
      else
        result << right.shift
      end
    end
    result + right + left
  end
end
