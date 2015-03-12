class Visit < ActiveRecord::Base
  validates :visitor_id, presence: true
  validates :shortened_url_id, presence: true

  belongs_to(
    :user,
    class_name: 'User',
    primary_key: :id,
    foreign_key: :visitor_id
  )

  belongs_to(
    :shortened_url,
    class_name: 'ShortenedUrl',
    primary_key: :id,
    foreign_key: :shortened_url_id
  )

  def self.record_visit!(user, short_url)
    shortened_url = ShortenedUrl.find_by( short_url: short_url )
    new_visit = Visit.new(
      { visitor_id: user.id, shortened_url_id: shortened_url.id }
    )
    new_visit.save
    new_visit
  end
end
