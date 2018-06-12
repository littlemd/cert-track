class Cert
  include DataMapper::Resource

  # property <name>, <type>
  property :id,       Serial
  property :name,     String,  :required => true
  property :needed,   Integer, :required => true, :default => 0
  property :duration, Integer, :required => true, :default => 0
  belongs_to :vendor
end
