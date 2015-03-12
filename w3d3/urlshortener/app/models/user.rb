class User < ActiveRecord::Base
  validates :email, presence: true, uniqueness: true

  has_many(
    :submitted_urls,
    class_name: 'ShortenedUrl',
    primary_key: :id,
    foreign_key: :submitter_id
  )

  has_many(
    :visits,
    class_name: 'Visit',
    primary_key: :id,
    foreign_key: :visitor_id
  )

  has_many(
    :visited_urls,
    -> { distinct },
    through: :visits,
    source: :shortened_url
  )

  def num_recent_submissions
    submitted_urls.select(:id).where("created_at > '#{1.minute.ago}'").count
  end
end
