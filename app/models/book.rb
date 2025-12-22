class Book < ApplicationRecord
  belongs_to :user
  has_one_attached :image
  validates :title, :author, :genre, presence: true

  def image_url
    Rails.application.routes.url_helpers.url_for(image) if image.attached?
  end
end
