# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  user_name  :string
#  created_at :datetime
#  updated_at :datetime
#

class User < ActiveRecord::Base
  validates :user_name, presence: true, uniqueness: true

  has_many(
    :authored_polls,
    primary_key: :id,
    foreign_key: :poll_id,
    class_name: 'Poll'
  )

  has_many(
    :responses,
    primary_key: :id,
    foreign_key: :user_id,
    class_name: 'Response'
  )

  has_many(
    :asked_questions,
    through: :authored_polls,
    source: :questions
  )

  def completed_polls
    sql = <<-SQL
    SELECT
      polls.title
    FROM
      polls
    JOIN
      questions ON polls.id = questions.poll_id
    JOIN
      answer_choices ON questions.id = answer_choices.question_id
    LEFT OUTER JOIN (
      SELECT
        *
      FROM
        responses
      WHERE
        responses.user_id = 1
      ) AS subq ON answer_choices.id = subq.answer_choice_id

    GROUP BY
      polls.id
    HAVING
      COUNT(DISTINCT questions.id) = COUNT(subq.id)
    SQL
  end

  def completed_polls_AR
    
  end
end
# COUNT(DISTINCT questions.id) AS num_qs_in_poll, COUNT(subq.id) AS rs_by_user
