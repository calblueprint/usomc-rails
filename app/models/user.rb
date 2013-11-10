# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  first_name      :string(255)
#  last_name       :string(255)
#  id_number       :integer
#  date_of_birth   :date
#  email           :string(255)
#  created_at      :datetime
#  updated_at      :datetime
#  password_digest :string(255)
#  country         :string(255)
#  street_address  :string(255)
#  city            :string(255)
#  state           :string(255)
#  zip_code        :string(255)
#  phone_number    :string(255)
#  remember_token  :string(255)
#

class User < ActiveRecord::Base
  rolify :role_cname => 'Judge'
  rolify :role_cname => 'Contestant'
  rolify :role_cname => 'Admin'
  after_create :assign_default_role

  has_many :events_users
  has_many :events, :through => :events_users

  has_secure_password

  before_save { email.downcase! }

  validates :first_name, :last_name, :email, :country, :street_address,
            :city, :state, :zip_code, :phone_number, presence: true
  validates_date :date_of_birth, :on_or_before => lambda { Date.current }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, format: { with: VALID_EMAIL_REGEX },
            uniqueness: { case_sensitive: false }
  validates :password, length: { minimum: 6 }

  def self.to_json(users)
      return users.collect {|user| user.to_json}
  end

  def to_json
    return {
      encid: id,
      first_name: first_name,
      last_name: last_name,
      country: country
    }
  end

  def User.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def User.encrypt(token)
    Digest::SHA1.hexdigest(token.to_s)
  end

  private

    def create_remember_token
      self.remember_token = User.encrypt(User.new_remember_token)
    end

    def assign_default_role
      self.add_role :contestant
    end
end
