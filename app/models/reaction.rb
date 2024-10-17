class Reaction < ApplicationRecord
  belongs_to :user
  belongs_to :post

  Kinds = %w[like dislike not_interested neutral].freeze

  validates :kind, inclusion: { in: Kinds, message: "%{value} no es un tipo de reacción válido" }
  validates :user_id, uniqueness: { scope: :post_id, message: "Ya has reaccionado a este post" }
end
