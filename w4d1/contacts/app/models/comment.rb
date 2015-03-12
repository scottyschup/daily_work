class Comments < ActiveRecord::Base
  validates :commentable_id, :commentable_type, presence: true

  belongs_to(
    :commentable,
    polymorphic: true,
    # class_name: :commentable_type.constantize,
    # foreign_key: :commentable_id,
    # primary_key: :id
  )
end
