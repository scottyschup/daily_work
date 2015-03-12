# == Schema Information
#
# Table name: questions
#
#  id         :integer          not null, primary key
#  content    :string
#  poll_id    :integer
#  created_at :datetime
#  updated_at :datetime
#

class Question < ActiveRecord::Base
  validates :content, presence: true
  validates :poll_id, presence: true

  has_many(
    :answer_choices,
    primary_key: :id,
    foreign_key: :question_id,
    class_name: 'AnswerChoice'
  )

  belongs_to(
    :poll,
    primary_key: :id,
    foreign_key: :poll_id,
    class_name: 'Poll'
  )

  has_many(
    :responses,
    through: :answer_choices,
    source: :responses
  )

  def results_n_plus_one
    choices_and_counts = Hash.new(0)
    answer_choices.each do |choice|
      choices_and_counts[choice.content] = choice.responses.count
    end

    choices_and_counts
  end

  def results_with_includes
    choices_and_counts = Hash.new(0)
    acs = answer_choices.includes(:responses)
    acs.each do |choice|
      choices_and_counts[choice.content] = choice.responses.length
    end

    choices_and_counts
  end

  def results_fbs
    sql_query = <<-SQL
      SELECT
        answer_choices.*, COUNT(responses.id) AS response_count
      FROM
        answer_choices
      LEFT OUTER JOIN
        responses ON answer_choices.id = responses.answer_choice_id
      WHERE
        answer_choices.question_id = 1
      GROUP BY
        answer_choices.id
    SQL
    Question.find_by_sql([sql_query, id])
  end

  def results
    answer_choices
      .select('answer_choices.*')
      .joins('LEFT OUTER JOIN responses
        ON answer_choices.id = responses.answer_choice_id')
      .where('answer_choices.question_id = ?', id)
      .group('answer_choices.content').count('responses.id')
  end

end
