class Object
  def test1
    p "Test 1 #{self}"
  end

  def test2
    p "Test 2 #{self}"
  end
end

t1 = Proc.new &:test1
t2 = Proc.new &:test2

t3 = Proc.new { |var| var ||= "almost works."; p "Test 3 #{var}"}
t4 = Proc.new { |var| var ||= "almost works."; p "Test 4 #{var}"}

tests = [t1, t2, t3, t4]

tests.map { |t| ['works!'].map(&t) }
