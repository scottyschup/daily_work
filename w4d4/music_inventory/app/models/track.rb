# == Schema Information
#
# Table name: tracks
#
#  id         :integer          not null, primary key
#  name       :string           not null
#  track_type :string
#  album_id   :integer
#  lyrics     :text
#  created_at :datetime
#  updated_at :datetime
#

class Track < ActiveRecord::Base
  validates :name, presence: true
  validates :album_id, presence: true
  validates :track_type, presence: true

  belongs_to :album
  has_one :band, through: :album
end
