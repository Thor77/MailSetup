require 'rubygems'
require 'data_mapper'

DataMapper.setup :default, 'postgres://vmail@localhost/vmail'

# Virtual User
class Vuser
  include DataMapper::Resource

  property :id, Serial
  property :name, String
  property :password, String, length: 120

  has n, :vdomains, through: Resource

  has n, :valiass
end

# Virtual Domain
class Vdomain
  include DataMapper::Resource

  property :id, Serial
  property :name, String

  has n, :vusers, through: Resource

  has n, :valiass
end

# Virtual Alias
class Valias
  include DataMapper::Resource

  property :id, Serial
  property :source, String

  belongs_to :vuser
  belongs_to :vdomain
end

DataMapper.finalize

DataMapper.auto_upgrade!
