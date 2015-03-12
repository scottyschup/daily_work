# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  username   :string           not null
#  created_at :datetime
#  updated_at :datetime
#

class User < ActiveRecord::Base
  validates :username, presence: true, uniqueness: true

  has_many(
    :contacts,
    class_name: 'Contact',
    primary_key: :id,
    foreign_key: :user_id
  )

  has_many(
    :contact_shares,
    class_name: 'ContactShare',
    primary_key: :id,
    foreign_key: :user_id,
    dependent: :destroy
  )

  has_many(
    :shared_contacts,
    through: :contact_shares,
    source: :contact
  )

  has_many(
    comments:,
    as: :commentable
  )

end
