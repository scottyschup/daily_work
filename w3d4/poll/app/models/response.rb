# == Schema Information
#
# Table name: responses
#
#  id               :integer          not null, primary key
#  user_id          :integer
#  answer_choice_id :integer
#  created_at       :datetime
#  updated_at       :datetime
#

class Response < ActiveRecord::Base
  validates :user_id, presence: true
  validates :answer_choice_id, presence: true
  validate :respondent_has_not_already_answered_question
  validate :author_cannot_respond_to_his_or_her_own_poll

  belongs_to(
    :respondent,
    primary_key: :id,
    foreign_key: :user_id,
    class_name: 'User'
  )

  belongs_to(
    :answer_choice,
    primary_key: :id,
    foreign_key: :answer_choice_id,
    class_name: 'AnswerChoice'
  )

  has_one(
    :question,
    through: :answer_choice,
    source: :question
  )

  def sibling_responses
    if self.id.nil?
      question.responses
    else
      question.responses.where('responses.id != ?', self.id)
    end
  end

  def respondent_has_not_already_answered_question
    if sibling_responses.where('responses.user_id = ?', self.user_id).exists?
      self.errors[:already_responded] =
      ["This respondent has already answered this question!"]
    end
  end

  def author_cannot_respond_to_his_or_her_own_poll
    if answer_choice.question.poll.author.id == user_id
      self.errors[:biased_results] =
      ["This respondent authored the original poll"]
    end
  end
end
