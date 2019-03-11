class BinaryMinheap
attr_reader :store, :prc

  def initialize(&prc)
    prc ||= Proc.new{|a,b| a<=>b}
    @prc = prc
    @store= []
    puts "gelo"
  end

  def count
    @store.length
  end

  def push(val)
    @store.push(val)
    BinaryMinheap.heapify_up(@store, @store.length-1, @store.length, &@prc)
  end
