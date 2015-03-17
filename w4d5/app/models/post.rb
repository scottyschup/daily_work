# == Schema Information
#
# Table name: posts
#
#  id         :integer          not null, primary key
#  title      :string           not null
#  url        :string
#  content    :text
#  author_id  :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Post < ActiveRecord::Base
  validates :title, :author_id, presence: true
  validates :subs, length: { minimum: 1 }

  belongs_to :author, class_name: :User, foreign_key: :author_id
  has_many :post_subs, inverse_of: :post
  has_many :subs, through: :post_subs, source: :sub
  has_many :comments, as: :commentable
end
