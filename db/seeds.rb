# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
puts 'initializing seed'
require 'faker'

puts 'Cleaning database...'
OrdoMedication.destroy_all
Medication.destroy_all
Ordonnance.destroy_all
Appointment.destroy_all
Patient.destroy_all
Doctor.destroy_all
User.destroy_all

puts 'Creating users...'
15.times do |i|
  user = User.new(
    email: "toto#{i}@gmail.com",
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    birthday: Faker::Date.birthday(min_age: 18, max_age: 65),
    password: 'password'
  )
  user.save!
end

puts 'Creating doctors...'
count = 0
5.times do
  count += 1
  Doctor.create!(
    user_id: User.find(count).id,
    specialty: Faker::IndustrySegments.industry,
    accreditation_number: Faker::Number.number(digits: 10)
  )
end

p 'Creating patients...'
5.times do
  Patient.create!(
    user_id: count += 1
  )
end

puts 'Creating appointments...'
10.times do |i|
  Appointment.create!(
    doctor_id: Faker::Number.between(from: 1, to: 5),
    patient_id: Faker::Number.between(from: 1, to: 5),
    appointment_date: Faker::Date.forward(days: 23),
    content: Faker::Lorem.paragraph(sentence_count: 2)
  )
end

puts 'Creating ordonnances...'
10.times do
  Ordonnance.create!(
    is_signed: true,
    is_sent: true,
    appointment_id: Faker::Number.between(from: 1, to: 10)
  )
end

puts 'Creating medications...'
10.times do
  Medication.create!(
    name: Faker::Science.tool,
    description: Faker::Food.description
  )
end

puts 'Creating ordo_medications...'
40.times do
  OrdoMedication.create!(
    ordonnance_id: Faker::Number.between(from: 1, to: 10),
    medication_id: Faker::Number.between(from: 1, to: 10)
  )
end
