# == Schema Information
#
# Table name: comments
#
#  id            :integer          not null, primary key
#  body          :string(255)
#  judge_id      :integer
#  contestant_id :integer
#  event_id      :integer
#  created_at    :datetime
#  updated_at    :datetime
#

class Comment < ActiveRecord::Base
  belongs_to :judge, class_name: "User"
  belongs_to :contestant, class_name: "User"
  belongs_to :event

  validates_presence_of :body

  def self.to_json(comments)
    return comments.collect {|comment| comment.to_json}
  end

  def to_json
    return {
      encid: id,
      body: body
    }
  end

end
