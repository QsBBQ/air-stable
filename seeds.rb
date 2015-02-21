require_relative 'config/dotenv'
require_relative 'models'
require 'faker'

User.destroy
Stall.destroy

u = User.new({:name => "Chuck Norris", :email => "cnorris@example.com", :password => "password"})
u.save

#users = []
10.times do
  user = User.create({
                      name: Faker::Name.name,
                      email: Faker::Internet.email,
                      password: "red"
                     })
  #stalls = []
  myuser = User.first(email: user.email)
  stall = myuser.stalls.create({
                              title: Faker::Company.bs,
                              description: Faker::Lorem.paragraph(2),
                              city: Faker::Address.city,
                              state: Faker::Address.state,
                              zipcode: Faker::Address.zip
                             })
end
