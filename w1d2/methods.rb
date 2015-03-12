def rps(choice)
  choices_array = [ 'Paper', 'Scissors', 'Rock']
  choice = choice.capitalize
  computer_choice = choices_array.sample

  if computer_choice == choice
    display_result(computer_choice, 'Draw')
  elsif choice == 'Paper'
    if computer_choice == 'Scissors'
      display_result(computer_choice, 'Lose')
    else
      display_result(computer_choice, 'Win')
    end
  elsif choice == 'Scissors'
    if computer_choice == 'Rock'
      display_result(computer_choice, 'Lose')
    else
      display_result(computer_choice, 'Win')
    end
  else
    if computer_choice == 'Paper'
      display_result(computer_choice, 'Lose')
    else
      display_result(computer_choice, 'Win')
    end
  end
end

def display_result(computer_choice, outcome)
  puts "#{computer_choice}, #{outcome}"
end


def remix(ingredients)
  alcohol, mixers = ingredients.transpose
  alcohol.shuffle.zip(mixers.shuffle)
end
