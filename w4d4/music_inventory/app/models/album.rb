# == Schema Information
#
# Table name: albums
#
#  id         :integer          not null, primary key
#  name       :string           not null
#  album_type :string
#  band_id    :integer          not null
#  created_at :datetime
#  updated_at :datetime
#

class Album < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true
  validates :album_type, presence: true
  validates :band_id, presence: true

  belongs_to :band
  has_many :tracks, dependent: :destroy
end
