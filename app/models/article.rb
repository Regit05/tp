class Article < ApplicationRecord
  has_many :comments, dependent: :destroy
  validates :title, presence: true,
            length: { minimum: 5 }

  scope :by_updated_at, -> { order(updated_at: :desc) }
  scope :online, -> (online) { where(online: online) }


end