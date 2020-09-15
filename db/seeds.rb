# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'faker'
Job.destroy_all
User.destroy_all

20.times do
  attr = {
    name: Faker::Name.name,
    email: Faker::Internet.email,
    password: "123123",
    password_confirmation: "123123"
  }
  new_performer = User.new(attr)
  new_performer.save
end

20.times do
  attr = {
    title: Faker::Job.title,
    description: Faker::GreekPhilosophers.quote,
    application_deadline_date: Faker::Date.in_date_period,
    location: Faker::Address.full_address,
    shoot_date: Faker::Date.in_date_period,
    job_status: "Pro-Bono"
  }
  new_job = Job.new(attr)
  my_user = User.offset(rand(User.count)).first
  new_job.user = my_user
  new_job.save
end