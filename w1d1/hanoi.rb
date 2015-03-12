def hanoi
  towers = {left: [4,3,2,1], middle: [], right: []}
  victory = false

  while victory == false
    source = ''
    destination = ''

    p towers

    puts "Which pile would you like to pick from? (left/middle/right)"
    source = gets.chomp.downcase.to_sym
    puts "Which pile would you like to move to? (left/middle/right)"
    destination = gets.chomp.downcase.to_sym

    towers = movement(source, destination, towers)


    victory = true if (towers == {left: [], middle: [], right: [4,3,2,1]})
  end

  print "You win!!\n"
end

# def towers
#   {left: [4,3,2,1], middle: [], right: []}
# end

def movement(source, destination, towers)
  if towers[destination].empty? || 
    (towers[source][-1] < towers[destination][-1])
    towers[destination].push(towers[source].pop)
  else
    print "Not a valid move.\n"
  end

  return towers
end

hanoi
