class Setting < ApplicationRecord
  has_many :options, dependent: :destroy
  has_many :user_settings, dependent: :destroy
  has_many :users, through: :user_settings, dependent: :destroy
end
