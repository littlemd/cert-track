migration 5, :create_usercerts do
  up do
    create_table :usercerts do
      column :id, Integer, :serial => true
      column :lic_code, DataMapper::Property::String, :length => 255
      column :completed, DataMapper::Property::Date
      column :expires, DataMapper::Property::Date
    end
  end

  down do
    drop_table :usercerts
  end
end
