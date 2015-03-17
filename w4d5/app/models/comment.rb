# == Schema Information
#
# Table name: comments
#
#  id               :integer          not null, primary key
#  content          :text             not null
#  author_id        :integer          not null
#  post_id          :integer          not null
#  commentable_id   :integer          not null
#  commentable_type :string           not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

class Comment < ActiveRecord::Base
  validates :author_id, :post_id, :commentable_id, :commentable_type, presence: true

  belongs_to :author, class_name: :User, foreign_key: :user_id
  belongs_to :post
  belongs_to :commentable, polymorphic: true
  has_many :comments, as: :commentable

end
