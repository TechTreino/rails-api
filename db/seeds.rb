# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

def generate_seed_data_for_all_environments
  puts '  BEGIN: Generating seed data for all environments'

  create_muscle_groups

  puts '  END: Generating seed data for all environments'
end

def create_muscle_groups
  return if MuscleGroup.any?

  ['Peito', 'Costas', 'Ombro', 'Bíceps', 'Tríceps', 'Lombar', 'Abdômem', 'Panturrilha', 'Coxa Posterior', 'Coxa Anterior'].each do |name|
    MuscleGroup.create(name: name)
  end
end

def generate_seed_data_for_development
  puts '  BEGIN: Generating seed data for development environments'

  FactoryGirl.create(:client) unless Client.any?
  FactoryGirl.create(
    :user,
    first_name: 'Admin',
    last_name: 'Cabuloso',
    email: 'admin@techtreino.com',
    password: '123456',
    roles: [:client_admin, :system_admin],
    client: Client.order(:created_at).first
  ) unless User.any?

  puts '  END: Generating seed data for development environments'
end

generate_seed_data_for_development if Rails.env.development?
generate_seed_data_for_all_environments unless Rails.env.test?