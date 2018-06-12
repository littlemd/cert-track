class Vendor
  include DataMapper::Resource

  # property <name>, <type>
  property :id,   Serial
  property :name, String, :required => true
  has n, :certs
end
