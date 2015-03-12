class ShortenedUrl < ActiveRecord::Base
  validates :submitter_id, presence: true
  validates :short_url, presence: true, uniqueness: true
  validates :long_url, presence: true, length: { maximum: 1024 }
  validate :not_a_spammer

  belongs_to(
    :submitter,
    class_name: 'User',
    primary_key: :id,
    foreign_key: :submitter_id
  )

  has_many(
    :visits,
    class_name: 'Visit',
    primary_key: :id,
    foreign_key: :shortened_url_id
  )

  has_many :visitors, -> { distinct }, through: :visits, source: :user


  has_many(
    :taggings,
    primary_key: :id,
    foreign_key: :shortened_url_id,
    class_name: 'Tagging'
  )

  has_many :tag_topics, through: :taggings, source: :tag_topic

  def self.random_code
    rand_str = SecureRandom::urlsafe_base64.first(16)

    while ShortenedUrl.exists?(short_url: rand_str)
      rand_str = SecureRandom::urlsafe_base64.first(16)
    end

    rand_str
  end

  def self.create_for_user_and_long_url!(user, long_url)
    short_url = ShortenedUrl.random_code
    params = { submitter_id: user.id, short_url: short_url, long_url: long_url}
    new_short = ShortenedUrl.new( params )
    new_short.save
    new_short
  end

  def num_clicks
    visits.select(:visitor_id).count
  end

  def num_uniques
    visitors.count
  end

  def num_recent_uniques
    visits.select(:visitor_id).distinct.where("created_at > '#{30.minutes.ago}'").count
  end

  private
  def not_a_spammer
    if submitter.num_recent_submissions > 5
      errors[:spammer] << "too many submissions in the last minute (>5)"
    end
  end
end
