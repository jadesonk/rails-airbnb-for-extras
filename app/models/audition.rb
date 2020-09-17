class Audition < ApplicationRecord
  belongs_to :user
  belongs_to :role
  has_one :job, through: :role
end
