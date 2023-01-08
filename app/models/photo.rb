class Photo < ApplicationRecord
  belongs_to :event
  belongs_to :user

  scope :persisted, -> { where "id IS NOT NULL" }

  has_one_attached :photo do |attachable|
    attachable.variant :thumb, resize_to_fit: [100, 100]
  end
end
