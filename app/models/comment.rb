class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :blog

  validates :content, prescence: true, length: { minimum: 10, maximum: 1000 }
end
