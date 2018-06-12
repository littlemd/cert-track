class Usercert
  include DataMapper::Resource

  # property <name>, <type>
  property :id,          Serial
  property :lic_code,    String,  :required => false
  property :completed,   Date,    :required => true
  property :expires,     Date,    :required => true
  belongs_to :cert
  belongs_to :account
end
