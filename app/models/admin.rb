# == Schema Information
#
# Table name: admins
#
#  id            :integer          not null, primary key
#  name          :string(255)
#  resource_id   :integer
#  resource_type :string(255)
#  created_at    :datetime
#  updated_at    :datetime
#

class Admin < User
  has_and_belongs_to_many :users, :join_table => :users_admins
  belongs_to :resource, :polymorphic => true

  scopify

  def self.all
    User.with_role(:admin)
  end

end
