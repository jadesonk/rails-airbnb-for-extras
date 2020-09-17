class Role < ApplicationRecord
  belongs_to :job
  has_many :auditions
  has_many :users, through: :auditions
end
