require 'data_mapper'
require 'bcrypt'


DataMapper.setup(:default, ENV['DATABASE_URL'])

class User
  include DataMapper::Resource

  property :id, Serial
  property :created_by, String
  property :name, String
  property :email, String, :required => true, :unique => true
  #Interesting password was accepting blank passwords even with required granted hashed.
  #So added length need to revisit
  property :password, BCryptHash, :required => true #, :length => 2..20
  property :created_at, DateTime
end

DataMapper.finalize
DataMapper.auto_upgrade!
