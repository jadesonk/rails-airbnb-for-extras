# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'faker'
require 'nokogiri'
require 'open-uri'
require 'watir'

puts "Destroy Jobs"
Job.destroy_all if Rails.env.development?

puts "Destroy Performers"
User.destroy_all if Rails.env.development?

puts "Create Performers"

img_url = 'https://api.generated.photos/api/v1/faces?api_key=_jzNSfLWW-2wUUlqP7rHGQ'
imgs = JSON.parse(open(img_url).read)
img_array = []
imgs["faces"].each do |item|
  img_array << item["urls"].last["512"]
end

10.times do
  attr = {
    name: Faker::Name.name,
    email: Faker::Internet.email,
    password: "123123",
    password_confirmation: "123123",
    gender: Faker::Demographic.sex,
    physical_attributes: Faker::Demographic.height(unit: :imperial),
    ethnicity: Faker::Demographic.race,
    age: Random.rand(18...42),
    image: img_array.sample
  }
  new_performer = User.new(attr)
  new_performer.save
end

puts "Create Jobs"

url = 'https://www.backstage.com/casting/'
browser = Watir::Browser.new :chrome, headless: true
browser.goto url
doc = Nokogiri::HTML.parse(browser.html)

doc.search('.casting__listing--prod').each do |element|
  attr = {
    title: element.search('.prod__title a').text.strip,
    description: element.search('.prod__desc').text.strip[12..-1],
    application_deadline_date: Faker::Date.in_date_period,
    location: Faker::Address.full_address,
    shoot_date: Faker::Date.in_date_period,
    job_status: "Pro-Bono"
  }
  new_job = Job.new(attr)
  my_user = User.offset(rand(User.count)).first
  new_job.user = my_user

  # create roles for job



  new_job.save
end

puts "Complete Seed"
