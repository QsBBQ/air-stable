require_relative 'config/dotenv'
require_relative 'models'
require 'faker'

User.all.destroy
Stall.all.destroy
RentalRequest.all.destroy

u = User.new({:name => "Chuck Norris", :email => "cnorris@example.com", :password => "password"})
u.save


10.times do
  user = User.create({
                      name: Faker::Name.name,
                      email: Faker::Internet.email,
                      password: "red"
                     })
  stall = Stall.create({
                              title: Faker::Company.bs,
                              description: Faker::Lorem.paragraph(2),
                              city: Faker::Address.city,
                              state: Faker::Address.state,
                              zipcode: Faker::Address.zip,
                              creator: user
                             })
  #another variation both work
  # stall = user.stalls.create({
  #                             title: Faker::Company.bs,
  #                             description: Faker::Lorem.paragraph(2),
  #                             city: Faker::Address.city,
  #                             state: Faker::Address.state,
  #                             zipcode: Faker::Address.zip,
  #                            })
end
