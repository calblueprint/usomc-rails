# == Schema Information
#
# Table name: events
#
#  id             :integer          not null, primary key
#  name           :text
#  created_at     :datetime
#  updated_at     :datetime
#  start_time     :time
#  room_id        :integer
#  competition_id :integer
#  max_time       :integer
#

require 'spec_helper'

describe Event do
  pending "add some examples to (or delete) #{__FILE__}"
end
