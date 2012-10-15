namespace :db do
	desc "Fill database with sample data"
	task populate: :environment do
		admin = User.create!(name: "Lukah", email: "lukahzero@gmail.com", password: "w0rdpass", password_confirmation: "w0rdpass")
		admin.toggle!(:admin)
		30.times do |n|
			name = Faker::Name.name
			email = "user-#{n+1}@railstutorial.com"
			password = "password"
			User.create!(name: name, email: email, password: password, password_confirmation: password)
		end
		
	end
end
