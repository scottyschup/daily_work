# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
#
users = User.create!([{ user_name: 'Scott' }, { user_name: 'Dan' },
                      { user_name: 'Narb' }, { user_name: 'Rayyan' },
                      { user_name: 'Bartholomew' }])

polls = Poll.create!([{ title: 'Friday Night', author_id: users.first.id },
                      { title: 'Lunch', author_id: users.last.id }])

questions = Question.create!([
  { poll_id: polls.first.id, content: 'When?' },
  { poll_id: polls.first.id, content: 'Where?' },
  { poll_id: polls.last.id, content: 'Why?' },
  { poll_id: polls.last.id, content: 'How?' }
])

answer_choices = AnswerChoice.create!([
  { content: 'first', question_id: questions[0].id},
  { content: 'second', question_id: questions[0].id},
  { content: 'fifth', question_id: questions[1].id},
  { content: 'sixth', question_id: questions[1].id},
  { content: 'seventh', question_id: questions[2].id},
  { content: 'eighth', question_id: questions[2].id},
  { content: 'third', question_id: questions[3].id},
  { content: 'fourth', question_id: questions[3].id}
])

responses = Response.create!([
  { user_id: users[0].id, answer_choice_id: answer_choices[4].id},
  { user_id: users[0].id, answer_choice_id: answer_choices[6].id},
  { user_id: users[1].id, answer_choice_id: answer_choices[0].id},
  { user_id: users[1].id, answer_choice_id: answer_choices[2].id},
  { user_id: users[2].id, answer_choice_id: answer_choices[1].id},
  { user_id: users[2].id, answer_choice_id: answer_choices[3].id},
  { user_id: users[3].id, answer_choice_id: answer_choices[5].id},
  { user_id: users[3].id, answer_choice_id: answer_choices[7].id},
  { user_id: users[4].id, answer_choice_id: answer_choices[0].id}])
