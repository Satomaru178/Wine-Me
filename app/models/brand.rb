class Brand < ApplicationRecord

  belongs_to :user
  belongs_to :type
  belongs_to :variety
  has_many   :likes, dependent: :destroy
  has_many   :comments, dependent: :destroy
  has_many   :images, dependent: :destroy

  belongs_to_active_hash :scene
  belongs_to_active_hash :taste

  validates :name, presence: true, length: { maximum: 40 }
  validates :explain, length: { maximum: 1_000 }

end
