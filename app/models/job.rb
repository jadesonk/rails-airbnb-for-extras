class Job < ApplicationRecord
  belongs_to :user
  has_many :roles
  validates :title, :description, presence: true
end
