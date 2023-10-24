class UserSetting < ApplicationRecord
  belongs_to :user
  belongs_to :setting
  belongs_to :option
end
