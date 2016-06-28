class User < ApplicationRecord
  ADMIN_EMAIL = 'admin@example.com'
  
  has_many :bookings
  has_many :rooms, through: :bookings

  has_many :booking_archives
  has_many :rooms, through: :booking_archives	

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable, :rememberable
  devise :database_authenticatable, :registerable,
         :recoverable, :trackable, :validatable

  validates :auth_token, uniqueness: true
  
  before_create :generate_auth_token!

  def generate_auth_token!
    begin
      self.auth_token = Devise.friendly_token
    end while self.class.exists?(auth_token: auth_token)
  end
         
end
