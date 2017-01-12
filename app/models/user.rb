class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  devise :omniauthable, :omniauth_providers => [:facebook, :github]

  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :events, dependent: :destroy
  has_many :subscriptions, dependent: :destroy
  has_many :categories, through: :subscriptions
  has_many :chat_rooms, dependent: :destroy
  has_many :messages, dependent: :destroy

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      # user.name = auth.info.name   # assuming the user model has a name
      # user.image = auth.info.image # assuming the user model has an image
    end
  end

  def name
    email.split('@')[0]
  end
end
