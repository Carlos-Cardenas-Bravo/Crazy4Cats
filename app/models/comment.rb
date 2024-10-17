class Comment < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :post

  has_many :reactions, dependent: :destroy
end
