require_relative 'models'

#Test
#Cleaning up
User.destroy

p User.count == 0
#Testing create
user = User.create({:name => "Chuck", :email => "cnorris@example.com", :password => "password"})

p User.count == 1

#Test read
chuck = User.first(:email => "cnorris@example.com")

p chuck.name == "Chuck"
p chuck.email == "cnorris@example.com"

#Test bcrypt
puts "bycrpt hash #{chuck.password}"
p chuck.password == "password"

#Testing validation
bruce = User.create({:name => "Chuck", :password => "password"})
p bruce.saved? == false
#Showing the list of errors
p bruce.errors[:email] == ["Email must not be blank"]

#Hmm need more tests
