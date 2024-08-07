namespace :admin do
  desc "Create an admin user"
  task create: :environment do
    print "Enter admin name: "
    name = STDIN.gets.chomp
    print "Enter admin email: "
    email = STDIN.gets.chomp
    print "Enter admin password: "
    password = STDIN.gets.chomp

    user = User.new(
      name: name,
      email: email,
      password: password,
      password_confirmation: password,
      admin: true
    )

    if user.save
      puts "Admin user created successfully."
    else
      puts "Error creating admin user:"
      puts user.errors.full_messages
    end
  end
end