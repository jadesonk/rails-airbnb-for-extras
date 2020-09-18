class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
				 :recoverable, :rememberable, :validatable
	has_many :auditions
	has_many :messages, through: :auditions
	has_many :created_jobs, class_name: "Job", dependent: :destroy
	has_many :applied_jobs, through: :auditions, source: :job
	validates :email, presence: true, uniqueness: true

  attr_reader :user
end
