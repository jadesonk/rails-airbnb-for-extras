class Job < ApplicationRecord
  belongs_to :user
  has_many :roles, dependent: :destroy
  validates :title, :description, presence: true
end
