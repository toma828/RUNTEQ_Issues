# frozen_string_literal: true

namespace :admin do
  desc 'Create an admin user'
  task create: :environment do
    print 'Enter admin name: '
    name = $stdin.gets.chomp
    print 'Enter admin email: '
    email = $stdin.gets.chomp
    print 'Enter admin password: '
    password = $stdin.gets.chomp

    user = User.new(
      name: name,
      email: email,
      password: password,
      password_confirmation: password,
      admin: true
    )

    if user.save
      puts 'Admin user created successfully.'
    else
      puts 'Error creating admin user:'
      puts user.errors.full_messages
    end
  end
end
