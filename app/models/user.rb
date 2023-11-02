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

  after_create :setup_user_settings

  def setup_user_settings
    UserSetting.create!(user_id: id, setting_id: 1, option_id: 1)
    UserSetting.create!(user_id: id, setting_id: 2, option_id: 6)
    UserSetting.create!(user_id: id, setting_id: 3, option_id: 8)
    UserSetting.create!(user_id: id, setting_id: 4, option_id: 9)
    UserSetting.create!(user_id: id, setting_id: 5, option_id: 11)
  end
end
