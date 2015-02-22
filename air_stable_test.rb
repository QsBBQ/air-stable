
require_relative 'config/dotenv'
require_relative 'models'


#Test models
#clean out db
User.all.destroy
Stall.all.destroy
RentalRequest.all.destroy

p User.count == 0
#Testing create
user = User.create({:name => "Chuck", :email => "cnorris@example.com", :password => "password"})

p User.count == 1

#Test read
chuck = User.first(:email => "cnorris@example.com")

p chuck.name == "Chuck"
p chuck.email == "cnorris@example.com"

#Test bcrypt
#puts "bycrpt hash #{chuck.password}"
p chuck.password == "password"

#Testing validation
bruce = User.create({:name => "Bruce Lee", :password => "password"})
p bruce.saved? == false
#Showing the list of errors
p bruce.errors[:email] == ["Email must not be blank"]

bruce = User.create({:name => "Bruce Lee", :email => "bruce@example.com", :password => "password"})
p bruce.id == nil
bruce = User.first(:email => "bruce@example.com")
puts "bruces id"
p bruce.id == !nil
p User.count == 2

#testing stalls

p Stall.count == 0
stall = chuck.stalls.create({ :title => "Test Title",
                       :description => "The is a great Test!",
                       :city => "Utopia",
                       :state => "fantasy island",
                       :zipcode => "60605"
                       } )
p Stall.count == 1
p stall.title == "Test Title"

#Test rental requests
# request = bruce.stall.rental_requests.create({
#                                         :date => "02/23/2015",
#                                         :message => "test message"
#                                        })

#p bruce.id
#p stall.id

p RentalRequest.count == 0
request = RentalRequest.create({
                                #:date => "02/23/2015",
                                :message => "test message",
                                :user => bruce,
                                :stall => stall
                              })
p RentalRequest.count == 1
