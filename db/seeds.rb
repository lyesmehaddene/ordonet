# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
puts 'initializing seed'
require 'faker'

puts 'Destroying all...'
OrdoMedication.destroy_all
Medication.destroy_all
Ordonnance.destroy_all
Appointment.destroy_all
Doctor.destroy_all
Patient.destroy_all
User.destroy_all

doctor_ids = []
patient_ids = []
appointment_ids = []

all_medications = [
  "Aspirine", "Lipitor", "Plavix", "Norvasc", "Coumadin",  # Cardiologue
  "Accutane", "Hydrocortisone", "Retin-A", "Benadryl", "Elidel",  # Dermatologue
  "OxyContin", "Ibuprofène", "Zofran", "Vicodin", "Morphine",  # Chirurgien
  "Amoxicilline", "Tylenol", "Zithromax", "Prozac", "Cymbalta"  # Généraliste
]

comments_by_specialty = {
  "Cardiologue" => [
    "Consultation initiale pour des épisodes récurrents de douleurs thoraciques. Je recommande un ECG et un échocardiogramme pour un diagnostic plus précis.",
    "Suivi post-opératoire de la chirurgie de pontage aorto-coronarien. Le patient montre des signes de récupération satisfaisante. Aucune complication observée.",
    "Examen de routine effectué. Aucun signe d'arythmie ou d'autres problèmes cardiaques. Poursuite du traitement médicamenteux actuel conseillée."
  ],
  "Dermatologue" => [
    "Consultation pour des symptômes persistants d'eczéma. Prescription d'une crème stéroïde topique et suivi dans 2 semaines pour évaluer l'efficacité.",
    "Un grain de beauté suspect sur le dos a été observé. Biopsie cutanée réalisée pour écarter tout risque de mélanome.",
    "Consultation pour acné sévère. Prescription de Doxycycline et recommandation d'un nettoyant facial doux. Suivi dans un mois."
  ],
  "Chirurgien" => [
    "Consultation préopératoire réalisée pour une hernie inguinale. Le patient est éligible pour une intervention chirurgicale. Planification de la chirurgie dans les deux semaines à venir.",
    "Suivi post-opératoire après ablation de la vésicule biliaire. Aucune complication post-chirurgicale notée. Les sutures seront retirées la semaine prochaine.",
    "Discussion avec le patient sur les options de traitement pour une appendicite aiguë. Une appendicectomie est recommandée."
  ],
  "Généraliste" => [
    "Consultation pour symptômes grippaux. Prescription d'antiviraux et repos recommandé. Si les symptômes persistent, envisager des tests supplémentaires.",
    "Examen physique annuel réalisé. Aucune anomalie détectée. Vaccinations à jour et conseils sur une alimentation équilibrée fournis.",
    "Consultation pour des épisodes de fatigue et de faiblesse. Des tests sanguins ont été recommandés pour évaluer les niveaux de fer et les fonctions thyroïdiennes."
  ]
}

puts 'Creating users...'
40.times do |i|
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
count = (User.last.id - 40)
20.times do
  count += 1
  doctor = Doctor.create!(
    user_id: User.find(count).id,
    specialty: ["Cardiologue", "Dermatologue", "Chirurgien", "Généraliste"].sample,
    accreditation_number: Faker::Number.number(digits: 10),
  )
  doctor_ids << doctor.id
end

p 'Creating patients...'
20.times do
  count += 1
  patient = Patient.create!(
    user_id: count,
  )
  patient_ids << patient.id
end

puts 'Creating appointments...'
50.times do |_i|
  doctor_id = doctor_ids.sample
  patient_id = patient_ids.sample
  appointment_date = Faker::Date.forward(days: 23)

  appointment = Appointment.new(
    doctor_id: doctor_id,
    patient_id: patient_id,
    appointment_date: appointment_date
  )

  specialty = Doctor.find(doctor_id).specialty

  appointment.content = comments_by_specialty[specialty].sample
  appointment.save!
  appointment_ids << appointment.id
end

puts 'Creating ordonnances...'
10.times do
  appointment_id = appointment_ids.sample
  Ordonnance.create!(
    is_signed: true,
    is_sent: true,
    appointment_id: appointment_id
  )
end

puts 'Creating medications...'
all_medications.each do |medication_name|
  Medication.create!(
    name: medication_name,
    description: Faker::Food.description
  )
end

# puts 'Creating ordo_medications...'
# 40.times do
#   OrdoMedication.create!(
#     ordonnance_id: Faker::Number.between(from: 1, to: 10),
#     medication_id: Faker::Number.between(from: 1, to: 10)
#   )
# end
