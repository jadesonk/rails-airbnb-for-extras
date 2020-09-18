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
# require 'watir'
require_relative 'seed-data'

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

puts "Create jobs with roles and auditions"

# url = 'https://www.backstage.com/casting/'
# browser = Watir::Browser.new :chrome, headless: true
# browser.goto url
# doc = Nokogiri::HTML.parse(browser.html)

# doc.search('.casting__listing--prod').each do |element|
20.times do
  attr = {
    # title: element.search('.prod__title a').text.strip,
    title: Faker::Marketing.buzzwords,
    # description: element.search('.prod__desc').text.strip[12..-1],
    description: Faker::Lorem.paragraph_by_chars(number: 140, supplemental: false),
    application_deadline_date: Faker::Date.in_date_period,
    location: Faker::Address.full_address,
    shoot_date: Faker::Date.in_date_period,
    job_status: "Pro-Bono"
  }
  new_job = Job.new(attr)
  my_user = User.offset(rand(User.count)).first
  new_job.user = my_user

  # create roles for job
  (2..4).to_a.sample.times do
    role_attr = {
      title: SeedData.roles.sample[:title],
      description: SeedData.roles.sample[:description]
    }
    new_role = Role.new(role_attr)
    new_role.job = new_job
    new_role.save

    # create fake audition
    (2..4).to_a.sample.times do
      audition_user = User.offset(rand(User.count)).first
      if audition_user != my_user
        new_audition = Audition.new(application_details: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.')
        new_audition.role = new_role
        new_audition.user = audition_user
        new_audition.save
      end
    end

  end
  new_job.save
end

puts "Complete Seed"
