migration 3, :create_certs do
  up do
    create_table :certs do
      column :id, Integer, :serial => true
      column :name, DataMapper::Property::String, :length => 255
      column :needed, DataMapper::Property::Integer
      column :duration, DataMapper::Property::Integer
    end
  end

  down do
    drop_table :certs
  end
end
