migration 2, :create_vendors do
  up do
    create_table :vendors do
      column :id, Integer, :serial => true
      column :name, DataMapper::Property::String, :length => 255
    end
  end

  down do
    drop_table :vendors
  end
end
