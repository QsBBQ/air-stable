require 'data_mapper'
require 'bcrypt'

#DataMapper::Logger.new($stdout, :debug)

DataMapper.setup(:default, ENV['DATABASE_URL'])

class User
  include DataMapper::Resource

  property :id, Serial
  property :name, String
  property :email, String, :required => true, :unique => true
  property :password, BCryptHash, :required => true #, :length => 2..20
  property :created_at, DateTime

  has n, :stalls, { :child_key => [:creator_id] }
  has n, :rental_requests
end

class Stall
  include DataMapper::Resource

  property :id, Serial
  property :title, String, :required => true
  property :description, Text, :required => true
  property :city, String, :required => true
  property :state, String, :required => true
  property :zipcode, String, :required => true
  property :created_at, DateTime

  belongs_to :creator, 'User'
  has n, :rental_request
end

class RentalRequest
  include DataMapper::Resource
  property :id, Serial
  property :status, String
  property :message, Text
  property :date, DateTime
  property :created_at, DateTime

  belongs_to :user
  belongs_to :stall
end

DataMapper.finalize
DataMapper.auto_upgrade!
