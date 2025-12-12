class Book < ApplicationRecord
  belongs_to :user
  validates :title, :author, :genre, presence: true
end
