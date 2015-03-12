require 'singleton'
require 'sqlite3'
require 'byebug'

require_relative 'model'

class QuestionsDatabase < SQLite3::Database
  include Singleton

  def initialize
    super('questions.db')
    self.results_as_hash = true
    self.type_translation = true
  end
end

class Question < DBModel
  def self.most_followed(n)
    QuestionFollower.most_followed_questions(n)
  end

  def self.most_liked(n)
    QuestionLike.most_liked_questions(n)
  end

  attr_accessor :id, :title, :body, :user_id

  def initialize(params = {})
    @id, @title, @body, @user_id =
      params.values_at('id', 'title', 'body', 'user_id')
  end

  def author
    User.find_by_id(@user_id)
  end

  def followers
    QuestionFollower.followers_for_question_id(@id)
  end

  def likers
    QuestionLike.likers_for_question_id(@id)
  end

  def num_likes
    QuestionLike.num_likes_for_question_id(@id)
  end

  def replies
    Reply.find_by_question_id(@id)
  end

  def save
    super('questions')
  end
end

class QuestionFollower
  def self.followers_for_question_id(question_id)
    results = QuestionsDatabase.instance.execute(<<-SQL, question_id)
      SELECT
        users.id, users.fname, users.lname
      FROM
        question_followers
      JOIN
        users ON users.id = question_followers.user_id
      WHERE
        question_followers.question_id = ?
    SQL

    results.map { |user_hash| User.new(user_hash) }
  end

  def self.followed_questions_for_user_id(user_id)
    results = QuestionsDatabase.instance.execute(<<-SQL, user_id)
      SELECT
        questions.id, questions.title, questions.body, questions.user_id
      FROM
        question_followers
      JOIN
        questions ON questions.id = question_followers.question_id
      WHERE
        question_followers.user_id = ?
    SQL

    results.map { |question_hash| Question.new(question_hash) }
  end

  def self.most_followed_questions(n)
    results = QuestionsDatabase.instance.execute(<<-SQL, n)
      SELECT
        questions.id, questions.title, questions.body, questions.user_id
      FROM (
        SELECT
          question_id, COUNT(*) AS follow_count
        FROM
          question_followers
        GROUP BY
          question_id
      ) AS grouped_followers
      JOIN
        questions ON questions.id = grouped_followers.question_id
      ORDER BY
        follow_count DESC
      LIMIT ?
    SQL

    results.map { |question_hash| Question.new(question_hash) }
  end
end

class QuestionLike
  def self.liked_questions_for_user_id(user_id)
    results = QuestionsDatabase.instance.execute(<<-SQL, user_id)
      SELECT DISTINCT
        questions.id, questions.title, questions.body, questions.user_id
      FROM
        questions
      JOIN
        question_likes ON questions.id = question_likes.question_id
      WHERE
        questions.user_id = ?
    SQL

    results.map { |question_hash| Question.new(question_hash) }
  end

  def self.likers_for_question_id(question_id)
    results = QuestionsDatabase.instance.execute(<<-SQL, question_id)
      SELECT
        users.id, users.fname, users.lname
      FROM
        question_likes
      JOIN
        users ON question_likes.user_id = users.id
      WHERE
        question_likes.question_id = ?
    SQL

    results.map { |user_hash| User.new(user_hash) }
  end

  def self.most_liked_questions(n)
    results = QuestionsDatabase.instance.execute(<<-SQL, n)
      SELECT
        questions.id, questions.title, questions.body, questions.user_id
      FROM (
        SELECT
          question_id, COUNT(*) AS like_count
        FROM
          question_likes
        GROUP BY
          question_id
      ) AS grouped_likers
      JOIN
        questions ON questions.id = grouped_likers.question_id
      ORDER BY
        like_count DESC
      LIMIT ?
    SQL

    results.map { |question_hash| Question.new(question_hash) }
  end

  def self.num_likes_for_question_id(question_id)
    results = QuestionsDatabase.instance.execute(<<-SQL, question_id)
      SELECT
        COUNT(*) AS num, question_id
      FROM
        question_likes
      GROUP BY
        question_id
      HAVING
        question_id = ?
    SQL

    results.empty? ? 0 : results.first['num']
  end
end

class Reply < DBModel
  attr_accessor :id, :body, :question_id, :user_id, :parent_id

  def initialize(params = {})
    @id, @body, @question_id, @user_id, @parent_id =
      params.values_at('id', 'body', 'question_id', 'user_id', 'parent_id')
  end

  def author
    User.find_by_id(@user_id)
  end

  def child_replies
    results = QuestionsDatabase.instance.execute(<<-SQL, @id)
      SELECT
        *
      FROM
        replies
      WHERE
        parent_id = ?
    SQL

    results.map { |reply_hash| Reply.new(reply_hash) }
  end

  def parent_reply
    Reply.find_by_id(@parent_id) unless @parent_id.nil?
  end

  def question
    Question.find_by_id(@question_id)
  end

  def save
    super('replies')
  end
end

class User < DBModel
  attr_accessor :id, :fname, :lname

  def initialize(params = {})
    @id, @fname, @lname = params.values_at('id', 'fname', 'lname')
  end

  def authored_questions
    Question.find_by_author_id(@id)
  end

  def authored_replies
    Reply.find_by_user_id(@id)
  end

  def average_karma
    results = QuestionsDatabase.instance.execute(<<-SQL, @id)
      SELECT
        AVG(likes.num_likes) AS ave_likes
      FROM (
        SELECT
          questions.id,
          COUNT(question_likes.id) AS num_likes
        FROM
          questions
        LEFT OUTER JOIN
          question_likes ON questions.id = question_likes.question_id
        GROUP BY
          questions.id
        HAVING
          questions.user_id = ?
      ) AS likes
    SQL

    results.first['ave_likes']
  end

  def followed_questions
    QuestionFollower.followed_questions_for_user_id(@id)
  end

  def liked_questions
    QuestionLike.liked_questions_for_user_id(@id)
  end

  def save
    super('users')
  end
end
