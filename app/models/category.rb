# == Schema Information
#
# Table name: categories
#
#  id             :integer          not null, primary key
#  competition_id :integer
#  name           :string(255)
#  age_limit      :integer
#  created_at     :datetime
#  updated_at     :datetime
#

class Category < ActiveRecord::Base
  belongs_to :competition
  has_many :display_events

  validates_presence_of :name

  def display_name
    if competition
      "'#{name}' from the #{competition.year} #{competition.name}"
    else
      "'#{name}'"
    end
  end

end
