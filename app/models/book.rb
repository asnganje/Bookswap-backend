class Book < ApplicationRecord
  belongs_to :user
  has_one_attached :image
  validates :title, :author, :genre, presence: true

  def image_url
    return unless image.attached?
    image.url
  end
end
