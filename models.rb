require 'data_mapper'
require 'bcrypt'


DataMapper.setup(:default, ENV['DATABASE_URL'])

class User
  include DataMapper::Resource

  property :id, Serial
  property :created_by, String
  property :name, String
  property :email, String, :required => true, :unique => true
  property :password, BCryptHash, :required => true #, :length => 2..20
  property :created_at, DateTime

  has n, :stalls, { :child_key => [:creator_id] }
end

class Stall
  include DataMapper::Resource

  property :id, Serial
  property :title, String, :required => true
  property :description, String, :required => true
  property :city, String, :required => true
  property :state, String, :required => true
  property :zipcode, String, :required => true
  property :created_at, DateTime

  belongs_to :creator, 'User'
end

DataMapper.finalize
DataMapper.auto_upgrade!
