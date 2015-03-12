require 'byebug'
def range(start, finish)
  return [] if finish - start < 2

  [start.next] + range(start.next, finish)
end
