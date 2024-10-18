# rubocop:disable Layout/EmptyLinesAroundClassBody
# == Schema Information
#
# Table name: comments
#
#  id         :bigint           not null, primary key
#  content    :text
#  user_id    :bigint
#  post_id    :bigint           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Comment < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :post

end

# rubocop:enable Layout/EmptyLinesAroundClassBody
