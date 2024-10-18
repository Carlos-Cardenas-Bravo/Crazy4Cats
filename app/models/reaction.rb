# == Schema Information
#
# Table name: reactions
#
#  id         :bigint           not null, primary key
#  user_id    :bigint           not null
#  kind       :string
#  post_id    :bigint           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Reaction < ApplicationRecord
  belongs_to :user
  belongs_to :post

  Kinds = %w[like dislike not_interested neutral].freeze

  validates :kind, inclusion: { in: Kinds, message: "%{value} no es un tipo de reacción válido" }
  validates :user_id, uniqueness: { scope: :post_id, message: "Ya has reaccionado a este post" }
end
