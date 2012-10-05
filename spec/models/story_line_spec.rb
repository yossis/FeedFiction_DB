# == Schema Information
#
# Table name: story_lines
#
#  id         :integer          not null, primary key
#  story_id   :integer
#  user_id    :integer
#  order_id   :integer          default(1)
#  line       :text
#  is_flagged :boolean
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

