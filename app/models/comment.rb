class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :user

  validates :content, presence: true
end