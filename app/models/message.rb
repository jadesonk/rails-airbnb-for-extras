class Message < ApplicationRecord
  belongs_to :audition
  belongs_to :user
end
