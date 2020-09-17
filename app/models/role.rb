class Role < ApplicationRecord
  belongs_to :job
  has_many :auditions, dependent: :destroy
  has_many :users, through: :auditions
end
