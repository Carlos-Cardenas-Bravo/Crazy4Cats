# == Schema Information
#
# Table name: posts
#
#  id         :bigint           not null, primary key
#  title      :string
#  content    :text
#  user_id    :bigint           not null
#  available  :boolean          default(TRUE)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :reactions, dependent: :destroy

  validates :title, presence: true, length: { maximum: 100 }
  validates :content, presence: true

  # Constantes para los tipos de reacciones
  Kinds = %w[like dislike not_interested neutral].freeze
  KindsSpanish = {
    "like" => "Me gusta",
    "dislike" => "No me gusta",
    "not_interested" => "No me interesa",
    "neutral" => "Neutral"
  }.freeze
end
