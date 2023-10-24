class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :categories
  has_many :user_articles
  has_many :articles, through: :user_articles
  has_many :favorites
  has_many :boards
  has_many :user_settings
  has_many :settings, through: :user_settings
end
